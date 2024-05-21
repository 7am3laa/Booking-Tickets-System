// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/CustomForFlightCards/fullticketcard.dart';

class FlightScreen extends StatelessWidget {
  List<FlightModel>? ticketList = [];

  FlightScreen({Key? key, this.ticketList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listFlight = [];
    for (var flight in ticketList!) {
      Map<String, dynamic> flightMap = {
        'arrivalAirportName': flight.arrivalAirportName,
        'arrivalAirportId': flight.arrivalAirportId,
        'arrivalTime': flight.arrivalTime,
        'flightNumber': flight.flightNumber,
        'departureAirportName': flight.departureAirportName,
        'departureAirportId': flight.departureAirportId,
        'departureTime': flight.departureTime,
        'price': flight.price,
        'airline': flight.airline,
        'airlineLogo': flight.airlineLogo,
        'hoursOfFlightDuration': flight.hoursOfFlightDuration,
        'minutesOfFlightDuration': flight.minutesOfFlightDuration,
        'extensions': flight.extensions,
        'travelClass': flight.travelClass,
      };
      listFlight.add(flightMap);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flights"),
        backgroundColor: const Color.fromARGB(255, 1, 14, 25),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listFlight.length,
        itemBuilder: (BuildContext context, int index) {
          final item = listFlight[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    itemDetails: item,
                    ishotel: false,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
              child: FullTicketCard(
                sourceName: item['departureAirportName'],
                sourceCode: item['departureAirportId'],
                destinationName: item['arrivalAirportName'],
                destinationCode: item['arrivalAirportId'],
                hoursOfFlyingTime: item['hoursOfFlightDuration'],
                minutesOfFlyingTime: item['minutesOfFlightDuration'],
                flightDate: item['departureTime'].split(' ')[0],
                flightTime: item['departureTime'].split(' ')[1],
                flightNumber: item['flightNumber'],
                airlineName: item['airline'],
                airlineLogo: item['airlineLogo'],
              ),
            ),
          );
        },
      ),
    );
  }
}
