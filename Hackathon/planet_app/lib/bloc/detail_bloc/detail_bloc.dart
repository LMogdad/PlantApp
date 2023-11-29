import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/detail_bloc/detail_event.dart';
import 'package:planet_app/bloc/detail_bloc/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(InitialState()) {
    on<AddPlantEvent>((event, emit) {
      emit(AddedState());
    });
  }
}
