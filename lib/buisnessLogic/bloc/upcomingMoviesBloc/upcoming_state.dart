part of 'upcoming_bloc.dart';

@immutable
class UpcomingState extends Equatable {
  final ApiRequestStatus apiRequestStatus;
  final ApiRequestStatus searchLoadStatus;
  final List<Result> moviesList;
  final List<Result> searchedList;
  final bool showSearchField;
  final bool showResultsCount;
  final int page;
  final int maxPages;

  const UpcomingState(
      {this.apiRequestStatus = const InitialApiRequestStatus(),
      this.searchLoadStatus = const InitialApiRequestStatus(),
      this.moviesList = const <Result>[],
      this.searchedList = const <Result>[],
      this.showSearchField = false,
      this.showResultsCount = false,
      this.page = 1,
      this.maxPages = -1,
      });

  UpcomingState copyWith(
      {ApiRequestStatus? apiRequestStatus,
      ApiRequestStatus? searchLoadStatus,
      List<Result>? moviesList,
      List<Result>? searchedList,
      bool? showSearchField,
      bool? showResultsCount,
      int? page,
      int? maxPages
      }) {
    return UpcomingState(
      apiRequestStatus: apiRequestStatus ?? this.apiRequestStatus,
      searchLoadStatus: searchLoadStatus ?? this.searchLoadStatus,
      moviesList: moviesList ?? this.moviesList,
      searchedList: searchedList ?? this.searchedList,
      showSearchField: showSearchField ?? this.showSearchField,
      showResultsCount: showResultsCount ?? this.showResultsCount,
      page: page ?? this.page,
      maxPages: maxPages ?? this.maxPages,
    );
  }

  @override
  List<Object?> get props =>
      [apiRequestStatus, moviesList,page,maxPages, showSearchField, searchLoadStatus,searchedList,showResultsCount];
}
