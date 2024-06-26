// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Cubits/User-cubit/user-cubit.dart';
import 'package:projectf/Screens/flightscreen.dart';
import 'package:projectf/Screens/hotelscreen.dart';
import 'package:projectf/Widgets/CustomForFlightCards/fullticketcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/hotelcard.dart';
import 'package:projectf/constant.dart';

class HomeScreen extends StatelessWidget {
  List<FlightModel>? ticketList = [];
  final bool? isloaded;
  HomeScreen({this.ticketList, super.key, this.isloaded});
  List<Map<String, dynamic>> hotelList = hotelList1;

  String check() {
    if (TimeOfDay.now().hour < 12) {
      return 'Good Morning';
    } else if (TimeOfDay.now().hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<UserCubit>(context).loggedInuser!;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 26,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${check()}, ',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      user.fName!.toLowerCase(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Book Ticket",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), 
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
                                  builder: (context) =>
                                      FlightScreen(  isLoad : isloaded,ticketList: ticketList),
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
                      child: isloaded!
                          ? ListView.builder(
                              itemCount: ticketList?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final item = ticketList![index];
                                print(
                                    'details of ${item.departureTime} + ${ticketList?.length}');
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: FullTicketCard(
                                    sourceName: item.departureAirportName,
                                    sourceCode: item.departureAirportId,
                                    destinationName: item.arrivalAirportName,
                                    destinationCode: item.arrivalAirportId,
                                    hoursOfFlyingTime:
                                        item.hoursOfFlightDuration,
                                    minutesOfFlyingTime:
                                        item.minutesOfFlightDuration,
                                    flightDate:
                                        item.departureTime.split(' ')[0],
                                    flightTime:
                                        item.departureTime.split(' ')[1],
                                    flightNumber: item.flightNumber,
                                    airlineLogo: item.airlineLogo,
                                    airlineName: item.airline,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                              '''
Sorry ${user.fName}..
Please Check Your Internet..!
''',
                              style: Styles.headlineStyle2
                                  .copyWith(color: Colors.red),
                            )),
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
        ],
      ),
    );
  }
}
