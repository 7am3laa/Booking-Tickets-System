import 'package:bloc/bloc.dart';

import 'package:projectf/Cubits/flight-Cubit/flight_state.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/flight_ticket.dart';

class FlightCubit extends Cubit<FlightState> {
  FlightCubit() : super(LoadingFlightState());

  DataBaseHandler dataBaseHandler = DataBaseHandler();

  getFlightsForUser(userId) async {
    try {
      emit(LoadingFlightState());
      List<Flight> flight = await dataBaseHandler.getFlightsForUser(userId);
      if (flight.isNotEmpty) {
        emit(LoadedFlightState(flight));
      } else if (flight.isEmpty) {
        emit(EmptyFlightState());
      }
    } catch (e) {
      emit(ErrorFlightState('$e'));
    }
  }

  deleteFlightForUser(int index, int id) async {
    try {
      await dataBaseHandler.deleteFlight(index);
      List<Flight> flight = await dataBaseHandler.getFlightsForUser(id);
      if (flight.isNotEmpty) {
        emit(LoadedFlightState(flight));
      } else if (flight.isEmpty) {
        emit(EmptyFlightState());
      }
    } catch (e) {
      emit(ErrorFlightState('$e'));
    }
  }

  addFlightForUser(
    int id,
    int numOfTickets,
    String sourceName,
    String destinationName,
    String sourceCode,
    String destinationCode,
    String flightDate,
    String flightTime,
     int price,
    int hoursOfFlightDuration,
    int minutesOfFlightDuration,
    
    String airlineLogo,
   
    String travelClass,
    String toatalFlightPrice,
  ) async {
    Flight flight = Flight(
      idflight: id,
      sourceName: sourceName,
      destinationName: destinationName,
      sourceCode: sourceCode,
      destinationCode: destinationCode,
      flightDate: flightDate,
      flightTime: flightTime,
      hoursOfFlightDuration: hoursOfFlightDuration,
      minutesOfFlightDuration: minutesOfFlightDuration,
      airlineLogo: airlineLogo,
      price: price,
      travelClass: travelClass,
      toatalFlightPrice: toatalFlightPrice,
      numOfTickets: numOfTickets,
    );

    await dataBaseHandler.saveFlight(flight);
  }
}
