// flight_search_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/search_cubits/fligth_search_cubit/flight_search_state.dart';

class FlightSearchCubit extends Cubit<FlightSearchState> {
  final List<Map<String, dynamic>> _ticketList;

  FlightSearchCubit(this._ticketList)
      : super(InitialFlightSearchState(ticketList: _ticketList));

  void search(String query) {
    if (query.isEmpty) {
      emit(InitialFlightSearchState(ticketList: _ticketList));
    } else {
      final filteredTickets = _ticketList.where((ticket) =>
          ticket['departureAirportName']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          ticket['arrivalAirportName']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          ticket['travelClass']
              .toLowerCase()
              .contains(query.toLowerCase())).toList();

      emit(SearchingFlightSearchState(ticketList: filteredTickets));
    }
  }
}