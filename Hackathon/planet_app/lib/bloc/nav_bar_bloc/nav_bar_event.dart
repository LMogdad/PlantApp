abstract class NavBarEvent {
  final int selection;

  NavBarEvent(this.selection);
}

class SelectScreenEvent extends NavBarEvent {
  SelectScreenEvent(super.selection);
}
