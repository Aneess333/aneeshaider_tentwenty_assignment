part of 'movie_details_bloc.dart';

@immutable
class MovieDetailsState extends Equatable {
  final ApiRequestStatus apiRequestStatus;
  final ApiRequestStatus urlRequestStatus;
  final MovieDetail? movieDetail;
  final String trailerUrl;

  const MovieDetailsState(
      {this.apiRequestStatus = const InitialApiRequestStatus(),
      this.urlRequestStatus = const InitialApiRequestStatus(),
      this.movieDetail,
      this.trailerUrl=""});

  MovieDetailsState copyWith(
      {ApiRequestStatus? apiRequestStatus,
      ApiRequestStatus? urlRequestStatus,
      MovieDetail? movieDetail,
      String? trailerUrl}) {
    return MovieDetailsState(
      apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
      urlRequestStatus: urlRequestStatus ?? this.urlRequestStatus,
      movieDetail: movieDetail ?? this.movieDetail,
      trailerUrl: trailerUrl ?? this.trailerUrl,
    );
  }

  @override
  List<Object?> get props => [apiRequestStatus, movieDetail, trailerUrl,urlRequestStatus,trailerUrl];
}
