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
}
