import 'package:flutter/material.dart';
import 'package:projectf/API/fetchFlights.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Widgets/CustomForFlightCards/fullticketcard.dart';

class FlightScreen extends StatelessWidget {
  List<FlightModel>? ticketList = [];

  FlightScreen({Key? key, this.ticketList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flights"),
        backgroundColor: const Color.fromARGB(255, 1, 14, 25),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ticketList!.length,
        itemBuilder: (BuildContext context, int index) {
          final item = ticketList![index];
          return Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            child: FullTicketCard(
              sourceName: item.departureAirportName,
              sourceCode: item.departureAirportId,
              destinationName: item.arrivalAirportName,
              destinationCode: item.arrivalAirportId,
              hoursOfFlyingTime: item.hoursOfFlightDuration,
              minutesOfFlyingTime: item.minutesOfFlightDuration,
              flightDate: item.departureTime.split(' ')[0],
              flightTime: item.departureTime.split(' ')[1],
              flightNumber: item.flightNumber,
              airlineLogo: item.airlineLogo,
              airlineName: item.airline,
            ),
          );
        },
      ),
    );
  }
}
