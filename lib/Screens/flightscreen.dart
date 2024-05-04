import 'package:flutter/material.dart';
import 'package:projectf/API/fetchFlights.dart';
import 'package:projectf/Widgets/CustomForFlightCards/fullticketcard.dart';
import 'package:projectf/constant.dart';

class FlightScreen extends StatelessWidget {
  FlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flights"),
        backgroundColor: const Color.fromARGB(255, 1, 14, 25),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: FetchFlights().getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> ticketList = snapshot.data ?? [];

            return ListView.builder(
              itemCount: ticketList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = ticketList[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: FullTicketCard(
                    sourceName: item['departure_airport_name'],
                    sourceCode: item['departure_airport_id'],
                    destinationName: item['arrival_airport_name'],
                    destinationCode: item['arrival_airport_id'],
                    flyingTime: item['flight_duration'],
                    flightDate: item['departure_time'].split(' ')[0],
                    flightTime: item['departure_time'].split(' ')[1],
                    flightNumber: item['flight_number'],
                    airlineLogo: item['airline_logo'],
                    airlineName: item['airline'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
