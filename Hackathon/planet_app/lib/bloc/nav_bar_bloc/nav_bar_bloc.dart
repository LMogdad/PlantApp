import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_event.dart';
import 'package:planet_app/bloc/nav_bar_bloc/nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(SelectState(0)) {
    on<SelectScreenEvent>((event, emit) {
      emit(SelectState(event.selection));
    });
  }
}
