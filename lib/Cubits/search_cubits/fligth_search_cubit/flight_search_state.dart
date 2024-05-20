class FlightSearchState {
  final List<Map<String, dynamic>> ticketList;

  FlightSearchState({required this.ticketList});
}

class InitialFlightSearchState extends FlightSearchState {
  InitialFlightSearchState({required List<Map<String, dynamic>> ticketList})
      : super(ticketList: ticketList);
}

class SearchingFlightSearchState extends FlightSearchState {
  SearchingFlightSearchState({required List<Map<String, dynamic>> ticketList})
      : super(ticketList: ticketList);
}