import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_event.dart';
import 'package:planet_app/bloc/schedule_bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(SelecTDateState(
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}')) {
    on<SelectDateEvent>((event, emit) {
      emit(SelecTDateState(event.date));
    });
  }
}
