import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_assessment/buisnessLogic/bloc/movieDetailBloc/movie_details_bloc.dart';
import 'package:tentwenty_assessment/helper/constants/image_resources.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/helper/utils/utils.dart';
import 'package:tentwenty_assessment/presentation/widgets/button_widget.dart';
import 'package:tentwenty_assessment/presentation/widgets/category_widget.dart';

import '../../buisnessLogic/api_request_status.dart';
import '../../dataProvider/model/respoonse/genre_model.dart';
import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/constant_resources.dart';
import '../../helper/constants/dimension_resources.dart';
import '../../helper/utils/dialog_utils.dart';
import '../router/routes.dart';
import '../widgets/custom_progress_hud.dart';
import '../widgets/text_view_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsBloc>().add(GetMovieDetails(id: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          ApiRequestStatus apiRequestStatus = state.apiRequestStatus;
          if (apiRequestStatus is ApiRequestStatusFailure) {
            DialogUtils.showErrorDialog(context,
                "${apiRequestStatus.errorMessage}(${apiRequestStatus.errorCode})");
          }
          if (state.urlRequestStatus is ApiRequestStatusSuccess &&
              state.trailerUrl.isNotEmpty) {

            Navigator.pushNamed(context, VIDEO_PLAYER_SCREEN,
                arguments: state.trailerUrl);
          }
        },
        builder: (context, state) {
          return CustomProgressHUD(
            inAsyncCall: (state.apiRequestStatus is ApiRequestStatusLoading || state.urlRequestStatus is ApiRequestStatusLoading),
            child: state.movieDetail == null
                ? const SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                width: MediaQuery.of(context).size.width,
                                color: Colorss.LIGHT_GREY_COLOR,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ConstantsResource.IMAGE_BASE_URL}${state.movieDetail?.posterPath}',
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                    color: Colorss.NAV_BAR_COLOR,
                                  )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity, // Ensures full width
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              margin: const EdgeInsets.only(bottom: Dim.D_16),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    // Dark filter at the bottom
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(Dim.D_10),
                              ),
                            ),
                            Positioned(
                                top: MediaQuery.of(context).padding.top +
                                    Dim.D_20,
                                left: Dim.D_20,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          ImagesResource.BACK_WHITE_ICON),
                                      const Padding(
                                          padding:
                                              EdgeInsets.only(left: Dim.D_20)),
                                      TextViewWidget(
                                        text: Strings.WATCH,
                                        align: TextAlign.start,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colorss.WHITE,
                                            ),
                                      )
                                    ],
                                  ),
                                )),
                            Positioned(
                              bottom: Dim.D_40,
                              left: Dim.D_0,
                              right: Dim.D_0,
                              child: Center(
                                child: Column(
                                  children: [
                                    TextViewWidget(
                                      text: state.movieDetail?.title ?? "",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colorss.WHITE,
                                          ),
                                    ),
                                    TextViewWidget(
                                      text: Strings.IN_THEATERRS +
                                          Utils().formatDate(
                                              state.movieDetail?.releaseDate),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colorss.WHITE,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: Dim.D_15,
                                    ),
                                    ButtonWidget(
                                      buttonText: Strings.GET_TICKETS,
                                      onTap: () {},
                                    ),
                                    const SizedBox(
                                      height: Dim.D_15,
                                    ),
                                    ButtonWidget(
                                      buttonText: Strings.WATCH_TRAILER,
                                      filled: false,
                                      icon: ImagesResource.PLAY_ICON,
                                      onTap: () {
                                        if (state.trailerUrl.isNotEmpty) {
                                          Navigator.pushNamed(
                                              context, VIDEO_PLAYER_SCREEN,
                                              arguments: state.trailerUrl);
                                        } else {
                                          context
                                              .read<MovieDetailsBloc>()
                                              .add(GetTrailerUrl());
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(Dim.D_24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextViewWidget(
                                text: Strings.GENRES,
                                align: TextAlign.start,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colorss.DARK_BLUE_COLOR,
                                    ),
                              ),
                              const SizedBox(
                                height: Dim.D_10,
                              ),
                              getRowOfGenres(state.movieDetail?.genres ?? []),
                              const SizedBox(
                                height: Dim.D_10,
                              ),
                              Divider(
                                color: Colorss.BLACK_COLOR.withOpacity(0.05),
                              ),
                              const SizedBox(
                                height: Dim.D_20,
                              ),
                              TextViewWidget(
                                text: Strings.OVERVIEW,
                                align: TextAlign.start,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colorss.DARK_BLUE_COLOR,
                                    ),
                              ),
                              const SizedBox(
                                height: Dim.D_10,
                              ),
                              TextViewWidget(
                                text: state.movieDetail?.overview ?? "",
                                align: TextAlign.start,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colorss.OVERVIEW_COLOR,
                                    ),
                              ),
                              const SizedBox(
                                height: Dim.D_10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget getRowOfGenres(List<Genre> list) {
    List<Widget> row = [];
    for (Genre genre in list) {
      row.add(CategoryWidget(
        categoryName: genre.name ?? "",
        color: Utils().getRandomDarkColor(),
      ));
      row.add(const SizedBox(
        width: Dim.D_5,
      ));
    }
    return Wrap(
      runSpacing: Dim.D_20,
      children: row,
    );
  }
}
