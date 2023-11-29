abstract class SearchState {
  final String searchText;

  SearchState(this.searchText);
}

class SelectState extends SearchState {
  SelectState(super.searchText);
}
