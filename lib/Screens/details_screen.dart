// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/User-cubit/user-cubit.dart';
import 'package:projectf/Cubits/flight-Cubit/flight_cubit.dart';
import 'package:projectf/Cubits/flight-Cubit/flight_state.dart';
import 'package:projectf/Cubits/hotels-Cubit/hotel_cubit.dart';
import 'package:projectf/Cubits/hotels-Cubit/hotel_state.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> itemDetails;
  final bool ishotel;

  const DetailsScreen({
    Key? key,
    required this.itemDetails,
    required this.ishotel,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListTile(
                      title: SeacrhFlightCard(
                        sourceName: widget.itemDetails['departureAirportName'],
                        sourceCode: widget.itemDetails['departureAirportId'],
                        destinationName:
                            widget.itemDetails['arrivalAirportName'],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: widget.ishotel
            ? BlocProvider(
                create: (context) => HotelCubit(),
                child: BlocBuilder<HotelCubit, HotelState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 60),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )),
                      onPressed: () {
                        BlocProvider.of<HotelCubit>(context).addHotelForUser(
                          widget.itemDetails['name'].toString(),
                          widget.itemDetails['place'].toString(),
                          widget.itemDetails['image'].toString(),
                          widget.itemDetails['price'].toString(),
                          totalPrice.toString(),
                          numberOfTickets,
                          BlocProvider.of<UserCubit>(context).loggedInuser!.id!,
                        );
                        showOK(context, color, 'Hotel');
                      },
                      child: Text('Book Now', style: Styles.headlineStyle1),
                    );
                  },
                ),
              )
            : BlocProvider(
                create: (context) => FlightCubit(),
                child: BlocBuilder<FlightCubit, FlightState>(
                  builder: (context, state) {
                    return ElevatedButton(
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
                      onPressed: () {
                        BlocProvider.of<FlightCubit>(context).addFlightForUser(
                          BlocProvider.of<UserCubit>(context).loggedInuser!.id!,
                          numberOfTickets,
                          widget.itemDetails['departureAirportName'],
                          widget.itemDetails['arrivalAirportName'],
                          widget.itemDetails['departureAirportId'],
                          widget.itemDetails['arrivalAirportId'],
                          widget.itemDetails['departureTime'].split(' ')[0],
                          widget.itemDetails['departureTime'].split(' ')[1],
                          widget.itemDetails['price'],
                          widget.itemDetails['hoursOfFlightDuration'],
                          widget.itemDetails['minutesOfFlightDuration'],
                          widget.itemDetails['airlineLogo'],
                          widget.itemDetails['travelClass'],
                          totalPrice.toString(),
                        );
                        print(BlocProvider.of<UserCubit>(context)
                            .loggedInuser!
                            .id!);

                        showOK(context, color, 'Flight');
                      },
                      child: Text('Book Now', style: Styles.headlineStyle1),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Future<dynamic> showOK(BuildContext context, Color color, String name) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.9,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 5),
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$name Booked successfully',
                      style: Styles.headlineStyle2.copyWith(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'pa'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
