abstract class HomeEvent {
  final int selection;

  HomeEvent(this.selection);
}

class SelectTabEvent extends HomeEvent {
  SelectTabEvent(super.selection);
}
