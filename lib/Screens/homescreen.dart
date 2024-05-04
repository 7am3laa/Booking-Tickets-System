import 'package:flutter/material.dart';
import 'package:projectf/API/fetchFlights.dart';
import 'package:projectf/Screens/flightscreen.dart';
import 'package:projectf/Screens/hotelscreen.dart';
import 'package:projectf/Widgets/CustomForFlightCards/fullticketcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/hotelcard.dart';
import 'package:projectf/constant.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<Map<String, dynamic>> ticketList = DataSet().ticketList;
  List<Map<String, dynamic>> hotelList = DataSet().hotelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 231, 229, 229),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Text(
                          "Good Morning",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Book Ticket",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15.0), // Adjust the border radius as needed
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Upcoming Flight",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FlightScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 10, 91, 158),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 230,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: FetchFlights().getNews(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          List<Map<String, dynamic>> ticketList =
                              snapshot.data ?? [];

                          return ListView.builder(
                            itemCount: ticketList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final item = ticketList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: FullTicketCard(
                                  sourceName: item['departure_airport_name'],
                                  sourceCode: item['departure_airport_id'],
                                  destinationName: item['arrival_airport_name'],
                                  destinationCode: item['arrival_airport_id'],
                                  flyingTime: item['flight_duration'],
                                  flightDate:
                                      item['departure_time'].split(' ')[0],
                                  flightTime:
                                      item['departure_time'].split(' ')[1],
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hotels",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 10, 91, 158),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hotelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = hotelList[index];
                        return HotelCard(
                          containerWidth: 300,
                          containerHeight: 150,
                          hotelImage: item['image'],
                          hotelName: item['name'],
                          hotelPlace: item['place'],
                          nightPrice: item['price'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
