
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/main_response.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/video_list.dart';

import '../model/respoonse/movie_detail.dart';


part 'network_api_client.g.dart';

@RestApi()
abstract class NetworkApiClient {
  factory NetworkApiClient(Dio dio, {String baseUrl}) = _NetworkApiClient;
  @GET("/movie/upcoming?page={page}")
  Future<MainResponse> loadMovies(@Path('page') int page);
  @GET("/search/movie?query={query}&include_adult=false&&page=1")
  Future<MainResponse> searchMovie(@Path('query') String query);
  @GET("/movie/{movieId}")
  Future<MovieDetail> movieDetails(@Path('movieId') int movieId);
  @GET("/movie/{movieId}/videos")
  Future<VideoList> videosList(@Path('movieId') int movieId);

}
