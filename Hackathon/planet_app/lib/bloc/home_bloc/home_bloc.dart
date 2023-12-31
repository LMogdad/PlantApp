import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/home_bloc/home_event.dart';
import 'package:planet_app/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(SelectState(0)) {
    on<SelectTabEvent>((event, emit) {
      emit(SelectState(event.selection));
    });
  }
}
