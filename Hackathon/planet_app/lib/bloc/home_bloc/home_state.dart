abstract class HomeState {
  final int selection;

  HomeState(this.selection);
}

class SelectState extends HomeState {
  SelectState(super.selection);
}
