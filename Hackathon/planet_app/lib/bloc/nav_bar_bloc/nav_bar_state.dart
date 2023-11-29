abstract class NavBarState {
  final int selection;

  NavBarState(this.selection);
}

class SelectState extends NavBarState {
  SelectState(super.selection);
}
