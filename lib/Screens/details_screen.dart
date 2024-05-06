// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/flight_ticket.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class DetailsScreen extends StatefulWidget {
  Users? users;
  final Map<String, dynamic> itemDetails;
  final bool ishotel;

  DetailsScreen({
    Key? key,
    this.users,
    required this.itemDetails,
    required this.ishotel,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  int numberOfTickets = 1;
  late int totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.itemDetails['price'];
  }

  int updateTotalPrice() {
    setState(() {
      totalPrice = widget.itemDetails['price'] * numberOfTickets;
    });
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: widget.ishotel
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchHotelCard(
                    image:
                        'assets/images/hotels/${widget.itemDetails['image'].toString()}',
                    name: widget.itemDetails['name'].toString(),
                    place: widget.itemDetails['place'].toString(),
                    price: widget.itemDetails['price'].toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (numberOfTickets > 1) {
                                numberOfTickets--;
                                updateTotalPrice();
                              }
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nights: ${numberOfTickets.toString()}',
                                style: Styles.headlineStyle1),
                            Text('Price: \$${totalPrice.toString()}',
                                style: Styles.headlineStyle1),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              numberOfTickets++;
                              updateTotalPrice();
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: SeacrhFlightCard(
                      sourceName: widget.itemDetails['departureAirportName'],
                      sourceCode: widget.itemDetails['departureAirportId'],
                      destinationName: widget.itemDetails['arrivalAirportName'],
                      destinationCode: widget.itemDetails['arrivalAirportId'],
                      hoursOfFlightDuration:
                          widget.itemDetails['hoursOfFlightDuration'],
                      minutesOfFlightDuration:
                          widget.itemDetails['minutesOfFlightDuration'],
                      flightDate:
                          widget.itemDetails['departureTime'].split(' ')[0],
                      flightTime:
                          widget.itemDetails['departureTime'].split(' ')[1],
                      flightNumber: widget.itemDetails['flightNumber'],
                      airline: widget.itemDetails['airline'],
                      airline_logo: widget.itemDetails['airlineLogo'],
                      price: widget.itemDetails['price'],
                      extensions: widget.itemDetails['extensions'],
                      travelClass: widget.itemDetails['travelClass'],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (numberOfTickets > 1) {
                                numberOfTickets--;
                                updateTotalPrice();
                              }
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tickets: ${numberOfTickets.toString()}',
                                style: Styles.headlineStyle1),
                            Text('Price: \$${totalPrice.toString()}',
                                style: Styles.headlineStyle1),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              numberOfTickets++;
                              updateTotalPrice();
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: widget.ishotel
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 60),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
                onPressed: () async {
                  String place = widget.itemDetails['name'].toString();
                  String des = widget.itemDetails['place'].toString();
                  int num = numberOfTickets;
                  String image = widget.itemDetails['image'].toString();
                  int total = updateTotalPrice();
                  Hotel hotel = Hotel(
                    idhotel: widget.users?.id,
                    place: place,
                    destination: des,
                    numOfTickets: num,
                    image: image,
                    pricehotel: (total * num).toString(),
                  );

                  await dataBaseHandler.saveHotel(hotel);
                  print(
                      '${widget.users?.id} ${hotel.destination} ${hotel.place} ${hotel.image} ${hotel.numOfTickets} ${hotel.pricehotel}');
                  SnackBar snackBar = const SnackBar(
                    content: Text(
                      'Hotel Booked successfully',
                    ),
                    duration: Duration(milliseconds: 500),
                  );
                  setState(() {});

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Book Now', style: Styles.headlineStyle1),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 60),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  int num = updateTotalPrice();
                  Flight flight = Flight(
                    idflight: widget.users?.id,
                    source: widget.itemDetails['departure_airport_name'],
                    destination: widget.itemDetails['arrival_airport_name'],
                    sourceCode: widget.itemDetails['departure_airport_id'],
                    destinationCode: widget.itemDetails['arrival_airport_id'],
                    date: widget.itemDetails['departure_time'].split(' ')[0],
                    departureTime:
                        widget.itemDetails['departure_time'].split(' ')[1],
                    flightDuration:
                        widget.itemDetails['flight_duration'].toString(),
                    price: widget.itemDetails['price'].toString(),
                  );
                  await dataBaseHandler.saveFlight(flight);
                  print(
                      '${widget.users?.id} | ${flight.destinationCode} | ${flight.source} | ${flight.price} | ${flight.date} | ${flight.departureTime} | ${flight.flightDuration} | ${flight.sourceCode} | ${flight.destination} ${flight.idflight}');
                  SnackBar snackBar = const SnackBar(
                    content: Text(
                      'Flight Booked successfully',
                    ),
                    duration: Duration(milliseconds: 500),
                  );
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Book Now', style: Styles.headlineStyle1),
              ),
            ),
    );
  }
}
