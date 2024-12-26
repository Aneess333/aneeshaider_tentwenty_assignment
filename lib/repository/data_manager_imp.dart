import '../dataProvider/model/respoonse/main_response.dart';
import '../dataProvider/model/respoonse/movie_detail.dart';
import '../dataProvider/model/respoonse/video_list.dart';

abstract class DataManagerImp {
  Future<MainResponse> loadMovies(int page);
  Future<MainResponse> searchMovie(String searchQuery);
  Future<MovieDetail> movieDetail(int movieId);
  Future<VideoList> videoList(int movieId);

}
