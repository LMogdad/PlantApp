import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/search_bloc/search_event.dart';
import 'package:planet_app/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SelectState("!@#%^&*()")) {
    on<SearchPlantEvent>((event, emit) {
      emit(SelectState(event.searchText));
    });
  }
}
