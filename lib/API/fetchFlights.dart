// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/DataBase/flight_ticket.dart';

class FetchFlights {
  FetchFlights();
  final dio = Dio();
  Future<List<FlightModel>> getNews() async {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final response = await dio.get(
        'https://serpapi.com/search.json?engine=google_flights&departure_id=ATL&arrival_id=DXB&outbound_date=$formattedDate&return_date=2024-05-30&gl=eg&currency=EGP&hl=en&api_key=f28e38473e4b228557b32ff411086ee2c1229fa3ac1760a72c09e4d6b2802253');
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> bestFlights = jsonData['best_flights'] ?? [];
    List<dynamic> otherFlights = jsonData['other_flights'] ?? [];

    List<FlightModel> flightDataList = [];
    try {
      for (var bestFlight in bestFlights) {
        List<dynamic> flights = bestFlight['flights'];

        for (var flight in flights) {
          Map<String, dynamic> departureAirport = flight['departure_airport'];
          Map<String, dynamic> arrivalAirport = flight['arrival_airport'];
          String flightNumber = flight['flight_number'].toString().substring(
                flight['flight_number'].toString().length - 3,
              );

          FlightModel flightModel = FlightModel(
            travelClass: flight['travel_class'],
            extensions: flight['extensions'],
            price: bestFlight['price'],
            hoursOfFlightDuration: (flight['duration'] / 60).floor(),
            minutesOfFlightDuration: (flight['duration']) % 60,
            airline: flight['airline'],
            airlineLogo: flight['airline_logo'],
            departureAirportName: _getAirportName(departureAirport['name']),
            departureAirportId: departureAirport['id'],
            departureTime: departureAirport['time'],
            arrivalAirportName: _getAirportName(arrivalAirport['name']),
            arrivalAirportId: arrivalAirport['id'],
            arrivalTime: arrivalAirport['time'],
            flightNumber: flightNumber,
          );
          flightDataList.add(flightModel);
        }
      }

      for (var otherflight in otherFlights) {
        List<dynamic> flights = otherflight['flights'];
        if (otherflight != null) {
          for (var flight in flights) {
            Map<String, dynamic> departureAirport = flight['departure_airport'];
            Map<String, dynamic> arrivalAirport = flight['arrival_airport'];
            String flightNumber = flight['flight_number'].toString().substring(
                  flight['flight_number'].toString().length - 3,
                );

            FlightModel flightModel = FlightModel(
              travelClass: flight['travel_class'],
              extensions: flight['extensions'],
              price: otherflight['price'],
              hoursOfFlightDuration: (flight['duration'] / 60).floor(),
              minutesOfFlightDuration: (flight['duration']) % 60,
              airline: flight['airline'],
              airlineLogo: flight['airline_logo'],
              departureAirportName: _getAirportName(departureAirport['name']),
              departureAirportId: departureAirport['id'],
              departureTime: departureAirport['time'],
              arrivalAirportName: _getAirportName(arrivalAirport['name']),
              arrivalAirportId: arrivalAirport['id'],
              arrivalTime: arrivalAirport['time'],
              flightNumber: flightNumber,
            );
            flightDataList.add(flightModel);
          }
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    return flightDataList;
  }

  String _getAirportName(String fullName) {
    List<String> parts = fullName.split(RegExp(r'\s+|-'));
    return parts[0];
  }
}
