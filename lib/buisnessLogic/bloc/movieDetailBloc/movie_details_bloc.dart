import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/movie_detail.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/video_links.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/video_list.dart';
import 'package:tentwenty_assessment/helper/constants/constant_resources.dart';

import '../../../helper/constants/strings_resources.dart';
import '../../../repository/data_manager.dart';
import '../../api_request_status.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(this.dataManager) : super(const MovieDetailsState()) {
    on<GetMovieDetails>(_onMovieDetails);
    on<GetTrailerUrl>(_onGetUrl);
  }
  final DataManager dataManager;
  Future<void> _onGetUrl(GetTrailerUrl event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(urlRequestStatus: ApiRequestStatusLoading()));
    try {
      VideoList videoList = await dataManager.videoList(state.movieDetail?.id??0);
      if (videoList.success == false) {

        emit(state.copyWith(
            urlRequestStatus: ApiRequestStatusFailure(videoList.statusCode,
                videoList.statusMessage ?? Strings.STH_WEN_WROONG)));
        emit(state.copyWith(urlRequestStatus: const InitialApiRequestStatus()));
      } else {
        List<VideoLink> list = videoList.videoLinks??[];
        String url = "";
        for(VideoLink videoLink in list){
          if(videoLink.type == "Trailer" && videoLink.site == "YouTube"){
            url = ConstantsResource.YOUTUBE_BASE_URL + (videoLink.key??"");
          }
        }
        emit(state.copyWith(
            urlRequestStatus: const ApiRequestStatusSuccess(),
            trailerUrl: url));
        emit(state.copyWith(
            urlRequestStatus: const InitialApiRequestStatus(),
            trailerUrl: url));
      }
    } catch (e) {
      emit(state.copyWith(
          urlRequestStatus:
          const ApiRequestStatusFailure(-1, Strings.STH_WEN_WROONG)));
      emit(state.copyWith(urlRequestStatus: const InitialApiRequestStatus()));
    }
  }
  Future<void> _onMovieDetails(GetMovieDetails event, Emitter<MovieDetailsState> emit) async {
    emit(state.copyWith(apiRequestStatus: ApiRequestStatusLoading()));
    try {
      MovieDetail movieDetail = await dataManager.movieDetail(event.id);
      if (movieDetail.success == false) {
        emit(state.copyWith(
            apiRequestStatus: ApiRequestStatusFailure(movieDetail.statusCode,
                movieDetail.statusMessage ?? Strings.STH_WEN_WROONG)));
        emit(state.copyWith(apiRequestStatus: const InitialApiRequestStatus()));
      } else {
        emit(state.copyWith(
            apiRequestStatus: const ApiRequestStatusSuccess(),
            movieDetail: movieDetail));
      }
    } catch (e) {
      emit(state.copyWith(
          apiRequestStatus:
          const ApiRequestStatusFailure(-1, Strings.STH_WEN_WROONG)));
      emit(state.copyWith(apiRequestStatus: const InitialApiRequestStatus()));
    }
  }
}
