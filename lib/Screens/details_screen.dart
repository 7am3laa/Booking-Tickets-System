// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/flight_ticket.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
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
                  Image.asset(
                      'assets/images/hotels/${widget.itemDetails['image']}'),
                  ListTile(
                    title: Text(
                      widget.itemDetails['name'].toString(),
                      style: Styles.headlineStyle1,
                    ),
                    subtitle: Text(
                      widget.itemDetails['place'].toString(),
                      style: Styles.headlineStyle3.copyWith(color: color),
                    ),
                    trailing: Text(
                      '\$${widget.itemDetails['price'].toString()}',
                      style: Styles.headlineStyle3.copyWith(color: color),
                    ),
                  ),
                  const Gap(50),
                  Row(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 150),
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
                          pricehotel: total,
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
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(
                  child: SeacrhFlightCard(
                    sourceCode: widget.itemDetails['from']['code'].toString(),
                    destinationCode:
                        widget.itemDetails['to']['code'].toString(),
                    source: widget.itemDetails['from']['name'].toString(),
                    destination: widget.itemDetails['to']['name'].toString(),
                    date: widget.itemDetails['date'].toString(),
                    departureTime:
                        widget.itemDetails['departure_time'].toString(),
                    flightDuration:
                        widget.itemDetails['flying_time'].toString(),
                    price: widget.itemDetails['price'].toString(),
                  ),
                ),
                const Gap(40),
                Row(
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
                Padding(
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
                        source: widget.itemDetails['from']['name'].toString(),
                        destination:
                            widget.itemDetails['to']['name'].toString(),
                        sourceCode:
                            widget.itemDetails['from']['code'].toString(),
                        destinationCode:
                            widget.itemDetails['to']['code'].toString(),
                        date: widget.itemDetails['date'].toString(),
                        departureTime:
                            widget.itemDetails['departure_time'].toString(),
                        flightDuration:
                            widget.itemDetails['flying_time'].toString(),
                        price: num.toString(),
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
              ],
            ),
    );
  }
}
