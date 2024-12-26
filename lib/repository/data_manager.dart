import 'package:dio/dio.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/main_response.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';

import '../dataProvider/model/respoonse/movie_detail.dart';
import '../dataProvider/model/respoonse/video_list.dart';
import '../dataProvider/network/network_api_client.dart';
import 'data_manager_imp.dart';

class DataManager implements DataManagerImp {
  late final NetworkApiClient _networkApiClient;

  DataManager({required NetworkApiClient networkApiClient}) {
    _networkApiClient = networkApiClient;
  }

  @override
  Future<MainResponse> loadMovies(int page) {
    return _networkApiClient
        .loadMovies(page)
        .then((successResponse) => successResponse)
        .catchError((e) {
      switch (e.runtimeType) {
        case DioError:
          return errorHandling(e);
        default:
          return MainResponse(
              statusCode: -1,
              statusMessage: Strings.STH_WEN_WROONG,
              success: false);
      }
    });
  }

  @override
  Future<MainResponse> searchMovie(String searchQuery) {
    return _networkApiClient
        .searchMovie(searchQuery)
        .then((successResponse) => successResponse)
        .catchError((e) {
          print(e);
          print("SD");
      switch (e.runtimeType) {
        case DioError:
          return errorHandling(e);
        default:
          return MainResponse(
              statusCode: -1,
              statusMessage: Strings.STH_WEN_WROONG,
              success: false);
      }
    });
  }
 @override
 Future<MovieDetail> movieDetail(int movieId) {
   return _networkApiClient
       .movieDetails(movieId)
       .then((successResponse) => successResponse)
       .catchError((e) {
     switch (e.runtimeType) {
       case DioError:
         return errorMovieDetail(e);
       default:
         return MovieDetail(
             statusCode: -1,
             statusMessage: Strings.STH_WEN_WROONG,
             success: false);
     }
   });
 }
 @override
 Future<VideoList> videoList(int movieId) {
    return _networkApiClient
        .videosList(movieId)
        .then((successResponse) => successResponse)
        .catchError((e) {
      switch (e.runtimeType) {
        case DioError:
          return errorHandlingVideoList(e);
        default:
          return VideoList(
              statusCode: -1,
              statusMessage: Strings.STH_WEN_WROONG,
              success: false);
      }
    });
  }

  MainResponse errorHandling(DioError e) {
    final errorResponse = e.response;
    if (errorResponse?.data["success"] != null &&
        errorResponse?.data["success"] == false) {
      MainResponse jsonResponse = MainResponse.fromJson(errorResponse?.data);
      return jsonResponse;
    } else {
      return MainResponse(
          statusCode: -1,
          statusMessage: Strings.STH_WEN_WROONG,
          success: false);

    }
  }VideoList errorHandlingVideoList(DioError e) {
    final errorResponse = e.response;
    if (errorResponse?.data["success"] != null &&
        errorResponse?.data["success"] == false) {
      VideoList jsonResponse = VideoList.fromJson(errorResponse?.data);
      return jsonResponse;
    } else {
      return VideoList(
          statusCode: -1,
          statusMessage: Strings.STH_WEN_WROONG,
          success: false);

    }
  }MovieDetail errorMovieDetail(DioError e) {
    final errorResponse = e.response;
    if (errorResponse?.data["success"] != null &&
        errorResponse?.data["success"] == false) {
      MovieDetail jsonResponse = MovieDetail.fromJson(errorResponse?.data);
      return jsonResponse;
    } else {
      return MovieDetail(
          statusCode: -1,
          statusMessage: Strings.STH_WEN_WROONG,
          success: false);

    }
  }
}
