part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent {}

class GetMovieDetails extends MovieDetailsEvent{
  final int id;
  GetMovieDetails({required this.id});
}
class GetTrailerUrl extends MovieDetailsEvent{
  GetTrailerUrl();
}
