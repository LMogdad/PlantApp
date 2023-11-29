abstract class SearchEvent {
  final String searchText;

  SearchEvent(this.searchText);
}

class SearchPlantEvent extends SearchEvent {
  SearchPlantEvent(super.searchText);
}
