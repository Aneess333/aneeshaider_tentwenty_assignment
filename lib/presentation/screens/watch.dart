import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assessment/buisnessLogic/api_request_status.dart';
import 'package:tentwenty_assessment/buisnessLogic/bloc/upcomingMoviesBloc/upcoming_bloc.dart';
import 'package:tentwenty_assessment/helper/constants/constant_resources.dart';
import 'package:tentwenty_assessment/helper/constants/image_resources.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/helper/utils/dialog_utils.dart';
import 'package:tentwenty_assessment/helper/utils/gener_handler.dart';
import 'package:tentwenty_assessment/presentation/router/routes.dart';
import 'package:tentwenty_assessment/presentation/widgets/text_view_widget.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimension_resources.dart';
import '../widgets/custom_progress_hud.dart';
import '../widgets/text_field.dart';

class Watch extends StatefulWidget {
  const Watch({super.key});

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<UpcomingBloc>().add(LoadUpcomingMovies());
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && context.read<UpcomingBloc>().state.apiRequestStatus is! ApiRequestStatusLoading) {
      context.read<UpcomingBloc>().add(LoadUpcomingMovies());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<UpcomingBloc, UpcomingState>(
      listener: (context, state) {
        ApiRequestStatus apiRequestStatus = state.apiRequestStatus;
        if (apiRequestStatus is ApiRequestStatusFailure) {
          DialogUtils.showErrorDialog(context,
              "${apiRequestStatus.errorMessage}(${apiRequestStatus.errorCode})");
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: (state.apiRequestStatus is ApiRequestStatusLoading ||
              state.searchLoadStatus is ApiRequestStatusLoading),
          child: Column(
            children: [
              const SizedBox(
                height: Dim.D_10,
              ),
              Visibility(
                  visible: (state.showResultsCount),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dim.D_24),
                child: Row(
                  children: [
                    GestureDetector(onTap: (){
                      textEditingController.clear();
                      context
                          .read<UpcomingBloc>()
                          .add(UpdateData(showSearchField: false,showResultsCount: false,resetSearch: true));
                    },child: SvgPicture.asset(ImagesResource.BACK_ICON)),
                    const SizedBox(width: Dim.D_20,),
                    TextViewWidget(
                      text: state.searchedList.length.toString()+Strings.RESULTS_FOUND,
                      textStyle:
                      Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colorss.DARK_BLUE_COLOR,
                      ),
                    ),
                  ],
                ),
              )),
              Visibility(
                visible: (state.showSearchField),
                child: CustomTextFormField(
                  focusNode: focusNode,
                  controller: textEditingController,
                  onChanged: (v) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 1000), () {
                      context
                          .read<UpcomingBloc>()
                          .add(SearchMovie(searchText: v));
                    });
                  },
                  onSubmit: (v){
                    if(v.isEmpty){
                      return;
                    }
                    context
                        .read<UpcomingBloc>()
                        .add(UpdateData(showSearchField: false,showResultsCount: true));
                  },
                  onClose: () {
                    context
                        .read<UpcomingBloc>()
                        .add(UpdateData(showSearchField: false,showResultsCount: false,resetSearch: true));
                    textEditingController.clear();
                  },
                ),
              ),
              if (!state.showSearchField && !state.showResultsCount)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dim.D_24) +
                      const EdgeInsets.only(top: Dim.D_10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextViewWidget(
                        text: Strings.WATCH,
                        textStyle:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colorss.DARK_BLUE_COLOR,
                                ),
                      ),
                      GestureDetector(
                          onTap: () {
                            context
                                .read<UpcomingBloc>()
                                .add(UpdateData(showSearchField: true));
                            focusNode.requestFocus();
                          },
                          child: SvgPicture.asset(ImagesResource.SEARCH_ICON))
                    ],
                  ),
                ),
              const SizedBox(
                height: Dim.D_20,
              ),
              if (state.moviesList.isNotEmpty &&
                  state.searchedList.isEmpty &&
                  state.searchLoadStatus is! ApiRequestStatusLoading &&
                  textEditingController.text.isEmpty)
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colorss.FIELD_BG,
                    padding: const EdgeInsets.symmetric(horizontal: Dim.D_24),
                    child: ListView.builder(
                      itemCount: state.moviesList.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap:(){
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pushNamed(context, MOVIE_DETAIL_ROUTE,arguments: state.moviesList[index].id);
                        },child: movieItem(index, state));
                      },
                    ),
                  ),
                ),
              if (state.searchedList.isNotEmpty ||
                  state.searchLoadStatus is ApiRequestStatusLoading|| textEditingController.text.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state.searchedList.isNotEmpty && !state.showResultsCount)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Dim.D_24),
                        child: TextViewWidget(
                          text: Strings.TOP_RESULTS,
                          align: TextAlign.start,
                          textStyle:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colorss.DARK_BLUE_COLOR,
                                  ),
                        ),
                      ),
                      if(state.searchedList.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Dim.D_24),
                        child: Divider(
                          color: Colorss.BLACK_COLOR.withOpacity(0.11),
                        ),
                      ),
                      if(state.searchedList.isNotEmpty)
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colorss.FIELD_BG,
                          padding:
                              const EdgeInsets.symmetric(horizontal: Dim.D_24),
                          child: ListView.builder(
                            itemCount: state.searchedList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(onTap:(){
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.pushNamed(context, MOVIE_DETAIL_ROUTE,arguments: state.searchedList[index].id);
                              },child: searchedMovieItem(index, state));
                            },
                          ),
                        ),
                      ),
                      if(state.searchedList.isEmpty)
                        Center(
                          child: TextViewWidget(
                            text: Strings.NO_RESULTS,
                            align: TextAlign.start,
                            maxLines: 2,
                            isEllipsis: true,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colorss.DARK_BLUE_COLOR,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    ));
  }
  Widget searchedMovieItem(int index,UpcomingState state){
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
              bottom: Dim.D_15) +
              EdgeInsets.only(
                  top: index == 0
                      ? Dim.D_24
                      : Dim.D_0),
          decoration: BoxDecoration(
            color: Colorss.LIGHT_GREY_COLOR,
            borderRadius:
            BorderRadius.circular(Dim.D_10),
          ),
          height: Dim.D_100,
          width: Dim.D_130,
          // Ensures full width
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                Dim.D_10), // Rounded corners
            child: CachedNetworkImage(
              imageUrl:
              '${ConstantsResource.IMAGE_BASE_URL}${state.searchedList[index].backdropPath}',
              placeholder: (context, url) =>
              const Center(
                  child:
                  CircularProgressIndicator(
                    color: Colorss.NAV_BAR_COLOR,
                  )),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
              fit: BoxFit.cover,
              height: Dim.D_100,
              width: Dim.D_130, // Ensures full width
            ),
          ),
        ),
        const SizedBox(
          width: Dim.D_10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              TextViewWidget(
                text:
                state.searchedList[index].title ??
                    "",
                align: TextAlign.start,
                maxLines: 2,
                isEllipsis: true,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colorss.DARK_BLUE_COLOR,
                ),
              ),
              TextViewWidget(
                text: GenreHandler().getGenresNames(
                    state.searchedList[index]
                        .genreIds ??
                        [0]),
                align: TextAlign.start,
                maxLines: 2,
                isEllipsis: true,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colorss.LIGHT_GREY_COLOR,
                ),
              )
            ],
          ),
        ),
        SvgPicture.asset(ImagesResource.OPTIONS_ICON)
      ],
    );
  }
  Widget movieItem(int index, UpcomingState state) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: Dim.D_15) +
              EdgeInsets.only(top: index == 0 ? Dim.D_24 : Dim.D_0),
          decoration: BoxDecoration(
            color: Colorss.LIGHT_GREY_COLOR,
            borderRadius: BorderRadius.circular(Dim.D_10),
          ),
          height: Dim.D_180,
          width: double.infinity,
          // Ensures full width
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dim.D_10), // Rounded corners
            child: CachedNetworkImage(
              imageUrl:
                  '${ConstantsResource.IMAGE_BASE_URL}${state.moviesList[index].backdropPath}',
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: Colorss.NAV_BAR_COLOR,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity, // Ensures full width
            ),
          ),
        ),
        Positioned(
          left: Dim.D_0,
          bottom: Dim.D_0,
          child: Container(
            height: Dim.D_60,
            margin: const EdgeInsets.only(bottom: Dim.D_16),
            width: MediaQuery.of(context).size.width - Dim.D_50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dim.D_10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  // Dark filter at the bottom
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: Dim.D_24,
          bottom: Dim.D_30,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextViewWidget(
              text: state.moviesList[index].title ?? "",
              align: TextAlign.start,
              maxLines: 2,
              isEllipsis: true,
              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colorss.WHITE,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
