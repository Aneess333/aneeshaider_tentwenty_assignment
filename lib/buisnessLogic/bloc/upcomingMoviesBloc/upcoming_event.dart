part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingEvent {}
class LoadUpcomingMovies extends UpcomingEvent {
  LoadUpcomingMovies();
}class UpdateData extends UpcomingEvent {
  final bool? showSearchField;
  final bool? showResultsCount;
  final bool? resetSearch;

  UpdateData({this.showSearchField,this.showResultsCount,this.resetSearch});
}class SearchMovie extends UpcomingEvent {
  final String searchText;
  SearchMovie({required this.searchText});
}