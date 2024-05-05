// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class FetchFlights {
  FetchFlights();
  final dio = Dio();
  Future<List<Map<String, dynamic>>> getNews() async {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final response = await dio.get(
        'https://serpapi.com/search.json?engine=google_flights&departure_id=SFO&arrival_id=ICN&outbound_date=$formattedDate&return_date=2024-05-30&gl=eg&currency=EGP&hl=en&api_key=f28e38473e4b228557b32ff411086ee2c1229fa3ac1760a72c09e4d6b2802253');
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> bestFlights = jsonData['best_flights'];

    List<Map<String, dynamic>> flightDataList = [];
    try {
      for (var bestFlight in bestFlights) {
        List<dynamic> flights = bestFlight['flights'];

        for (var flight in flights) {
          int price = bestFlight['price'];

          String airline = flight['airline'];
          String airlineLogo = flight['airline_logo'];
          int flightDuration = flight['duration'];

          Map<String, dynamic> departureAirport = flight['departure_airport'];
          String departureAirportName =
              _getAirportName(departureAirport['name']);
          String departureAirportId = departureAirport['id'];
          String departureTime = departureAirport['time'];

          Map<String, dynamic> arrivalAirport = flight['arrival_airport'];
          String arrivalAirportName = _getAirportName(arrivalAirport['name']);
          String arrivalAirportId = arrivalAirport['id'];
          String arrivalTime = arrivalAirport['time'];
          String flightNumber = flight['flight_number'].toString().substring(
                flight['flight_number'].toString().length - 3,
              );
          Map<String, dynamic> flightData = {
            'price': price,
            'flight_duration': flightDuration,
            'airline': airline,
            'airline_logo': airlineLogo,
            'departure_airport_name': departureAirportName,
            'departure_airport_id': departureAirportId,
            'departure_time': departureTime,
            'arrival_airport_name': arrivalAirportName,
            'arrival_airport_id': arrivalAirportId,
            'arrival_time': arrivalTime,
            'flight_number': flightNumber,
          };

          flightDataList.add(flightData);
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
