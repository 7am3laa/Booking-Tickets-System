import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectf/Screens/flightscreen.dart';
import 'package:projectf/Screens/hotelscreen.dart';
import 'package:projectf/Widgets/CustomForFlightCards/hotelcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/placeflightcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/timeflightcard.dart';
import 'package:projectf/constant.dart';

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
                                builder: (context) => FlightScreen(),
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
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ticketList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = ticketList[index];
                        return Column(
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
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
