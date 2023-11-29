abstract class ScheduleEvent {}

class SelectDateEvent extends ScheduleEvent {
  final String date;

  SelectDateEvent(this.date);
}
