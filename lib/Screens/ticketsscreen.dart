// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/flight_ticket.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class TicketsScreen extends StatefulWidget {
  final Users? user;

  const TicketsScreen({
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  bool isHotel = false;
  bool isSelected = true;
  DataBaseHandler dataBaseHandler = DataBaseHandler();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Tickets',
          style: Styles.headlineStyle2.copyWith(color: color),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelected = true;
                    isHotel = false;
                  });
                },
                child: Container(
                  width: AppLayout.getWidth(context) / 2.2,
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    ),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      'Flights Booked',
                      style: Styles.headlineStyle2.copyWith(
                        color: isSelected ? Colors.black : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelected = false;
                    isHotel = true;
                  });
                },
                child: Container(
                  width: AppLayout.getWidth(context) / 2.2,
                  height: 55,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.grey.shade300 : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      'Hotels Booked',
                      style: Styles.headlineStyle2.copyWith(
                        color: isSelected ? Colors.grey.shade600 : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isHotel
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: FutureBuilder<List<Hotel>>(
                      future: dataBaseHandler.getHotelsForUser(widget.user?.id),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          List<Hotel> hotels = snapshot.data!;
                          if (hotels.isEmpty) {
                            return Center(
                              child: Text(
                                'No Hotel Booked',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: hotels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          SearchHotelCard(
                                            image:
                                                'assets/images/hotels/${hotels[index].image}',
                                            name: hotels[index].place!,
                                            place: hotels[index].destination!,
                                            price: hotels[index].pricehotel!,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '\$ ${hotels[index].totalPrice} / ${hotels[index].numOfTickets.toString()} Nights',
                                                  style: Styles.headlineStyle2
                                                      .copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'Delete Ticket',
                                                            style: Styles
                                                                .headlineStyle1
                                                                .copyWith(
                                                                    color:
                                                                        color),
                                                          ),
                                                          content: Text(
                                                            'Are you sure you want to delete this ticket?',
                                                            style: Styles
                                                                .headlineStyle2
                                                              ..copyWith(
                                                                  color: color),
                                                          ),
                                                          actions: [
                                                            Column(
                                                              children: [
                                                                Button(
                                                                    width: 1,
                                                                    onTap:
                                                                        () async {
                                                                      await dataBaseHandler
                                                                          .deleteHotel(
                                                                              hotels[index].id!);
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    text:
                                                                        'Delete',
                                                                    color: Colors
                                                                        .red,
                                                                    textColor:
                                                                        Colors
                                                                            .white),
                                                                const Gap(10),
                                                                Button(
                                                                  width: 1,
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  text:
                                                                      'Cancel',
                                                                  color: Colors
                                                                      .white,
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                    color: Colors.red.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: FutureBuilder<List<Flight>>(
                      future:
                          dataBaseHandler.getFlightsForUser(widget.user?.id),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          List<Flight> flights = snapshot.data!;
                          if (flights.isEmpty) {
                            return Center(
                              child: Text(
                                'No Flight Booked',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: flights.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        SeacrhFlightCard(
                                          sourceCode: flights[index]
                                              .sourceCode
                                              .toString(),
                                          destinationCode: flights[index]
                                              .destinationCode
                                              .toString(),
                                          sourceName: flights[index]
                                              .sourceName
                                              .toString(),
                                          destinationName: flights[index]
                                              .destinationName
                                              .toString(),
                                          flightDate: flights[index]
                                              .flightDate
                                              .toString(),
                                          flightTime: flights[index]
                                              .flightTime
                                              .toString(),
                                          hoursOfFlightDuration: flights[index]
                                              .hoursOfFlightDuration!,
                                          minutesOfFlightDuration:
                                              flights[index]
                                                  .minutesOfFlightDuration!,
                                          airline_logo:
                                              flights[index].airlineLogo!,
                                          price: flights[index].price!,
                                          travelClass:
                                              flights[index].travelClass!,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$ ${flights[index].toatalFlightPrice} / ${flights[index].numOfTickets.toString()} Tickets',
                                                style: Styles.headlineStyle2
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Delete Ticket',
                                                          style: Styles
                                                              .headlineStyle1
                                                              .copyWith(
                                                                  color: color),
                                                        ),
                                                        content: Text(
                                                          'Are you sure you want to delete this ticket?',
                                                          style: Styles
                                                              .headlineStyle2
                                                              .copyWith(
                                                                  color: color),
                                                        ),
                                                        actions: [
                                                          Column(
                                                            children: [
                                                              Button(
                                                                  width: 1,
                                                                  onTap:
                                                                      () async {
                                                                    await dataBaseHandler
                                                                        .deleteFlight(
                                                                            flights[index].id!);
                                                                    Navigator.pop(
                                                                        context);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'Delete',
                                                                  color: Colors
                                                                      .red,
                                                                  textColor:
                                                                      Colors
                                                                          .white),
                                                              const Gap(10),
                                                              Button(
                                                                width: 1,
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                text: 'Cancel',
                                                                color: Colors
                                                                    .white,
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.red.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
