import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/placeflightcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/timeflightcard.dart';
import 'package:projectf/constant.dart';

class FlightScreen extends StatelessWidget {
  FlightScreen({super.key});
  List<Map<String, dynamic>> ticketList = DataSet().ticketList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flights"),
        backgroundColor: const Color.fromARGB(255, 1, 14, 25),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ticketList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = ticketList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
            child: Column(
              children: [
                PlaceFlightCard(
                    sourceName: item['from']['name'],
                    sourceCode: item['from']['code'],
                    destinationName: item['to']['name'],
                    destinationCode: item['to']['code'],
                    flyingTime: item['flying_time']),
                TimeFlightCard(
                  flightDate: item['date'],
                  flightTime: item['departure_time'],
                  flightNumber: item['number'],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
