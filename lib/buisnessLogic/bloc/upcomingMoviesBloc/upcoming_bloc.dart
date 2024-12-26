import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/main_response.dart';
import 'package:tentwenty_assessment/helper/constants/strings_resources.dart';
import 'package:tentwenty_assessment/repository/data_manager.dart';

import '../../../dataProvider/model/respoonse/results.dart';
import '../../api_request_status.dart';

part 'upcoming_event.dart';

part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  UpcomingBloc(this.dataManager) : super(const UpcomingState()) {
    on<LoadUpcomingMovies>(_onLoadMovies);
    on<UpdateData>(_onUpdateData);
    on<SearchMovie>(_onSearchMovie);
  }

  final DataManager dataManager;

  Future<void> _onSearchMovie(
      SearchMovie event, Emitter<UpcomingState> emit) async {
    if (event.searchText.isEmpty) {
      emit(state.copyWith(searchedList: []));
    }
    emit(state.copyWith(searchLoadStatus: ApiRequestStatusLoading()));
    try {
      MainResponse mainResponse =
          await dataManager.searchMovie(event.searchText);
      if (mainResponse.success == false) {
        emit(state.copyWith(
            searchLoadStatus: ApiRequestStatusFailure(mainResponse.statusCode,
                mainResponse.statusMessage ?? Strings.STH_WEN_WROONG)));
        emit(state.copyWith(apiRequestStatus: const InitialApiRequestStatus()));
      } else {
        emit(state.copyWith(
            searchLoadStatus: const ApiRequestStatusSuccess(),
            searchedList: mainResponse.results));
      }
    } catch (e) {
      emit(state.copyWith(
          searchLoadStatus:
              const ApiRequestStatusFailure(-1, Strings.STH_WEN_WROONG)));
      emit(state.copyWith(searchLoadStatus: const InitialApiRequestStatus()));
    }
  }

  Future<void> _onUpdateData(
      UpdateData event, Emitter<UpcomingState> emit) async {
    emit(state.copyWith(
        showSearchField: event.showSearchField,
        searchedList: event.resetSearch==true?[]:state.searchedList,
        showResultsCount: event.showResultsCount));
  }

  Future<void> _onLoadMovies(
      LoadUpcomingMovies event, Emitter<UpcomingState> emit) async {
    if(state.page== state.maxPages){
      return;
    }
    if(state.moviesList.isEmpty) {
      emit(state.copyWith(apiRequestStatus: ApiRequestStatusLoading()));
    }
    try {
      MainResponse mainResponse = await dataManager.loadMovies(state.page);
      if (mainResponse.success == false) {
        emit(state.copyWith(
            apiRequestStatus: ApiRequestStatusFailure(mainResponse.statusCode,
                mainResponse.statusMessage ?? Strings.STH_WEN_WROONG)));
        emit(state.copyWith(apiRequestStatus: const InitialApiRequestStatus()));
      } else {
        List<Result> moviesList = [];
        moviesList.addAll(state.moviesList);
        moviesList.addAll(mainResponse.results??[]);
        emit(state.copyWith(
            apiRequestStatus: const ApiRequestStatusSuccess(),
            maxPages: mainResponse.totalPages,
            page: state.page + 1,
            moviesList: moviesList));
      }
    } catch (e) {
      emit(state.copyWith(
          apiRequestStatus:
              const ApiRequestStatusFailure(-1, Strings.STH_WEN_WROONG)));
      emit(state.copyWith(apiRequestStatus: const InitialApiRequestStatus()));
    }
  }
}
