import 'package:projectf/DataBase/flight_ticket.dart';

class FlightState {}

class LoadingFlightState extends FlightState {}

class LoadedFlightState extends FlightState {
  final List<Flight> flight;

  LoadedFlightState(this.flight);
}

class EmptyFlightState extends FlightState {
  final String message = 'No Flights Booked';
  EmptyFlightState();
}

class ErrorFlightState extends FlightState {
  final String errorMessage;
  ErrorFlightState(this.errorMessage);
}
