// ignore_for_file: constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
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
  Users users = Users();
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  int numberOfTickets = 1;
  late int totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.itemDetails['price'];
  }

  void updateTotalPrice() {
    setState(() {
      totalPrice = widget.itemDetails['price'] * numberOfTickets;
    });
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
                        await dataBaseHandler.insertData(
                            "INSERT INTO hotel (place, destination, image, numOfTickets) VALUES ('${widget.itemDetails['name']}', '${widget.itemDetails['place']}', '${widget.itemDetails['image']}', '$numberOfTickets')");
                        var result = await dataBaseHandler.getHotelsForUser();
                        print('$result');

                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            'Booked successfully',
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
                    fromCode: widget.itemDetails['from']['code'].toString(),
                    toCode: widget.itemDetails['to']['code'].toString(),
                    from: widget.itemDetails['from']['name'].toString(),
                    to: widget.itemDetails['to']['name'].toString(),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 100),
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
                    onPressed: () {},
                    // onPressed: () async {
                    //   Flight flight = Flight(
                    //     fromCode: widget.itemDetails['from']['code'].toString(),
                    //     toCode: widget.itemDetails['to']['code'].toString(),
                    //     from: widget.itemDetails['from']['name'].toString(),
                    //     to: widget.itemDetails['to']['name'].toString(),
                    //     date: widget.itemDetails['date'].toString(),
                    //     departureTime:
                    //         widget.itemDetails['departure_time'].toString(),
                    //     flightDuration:
                    //         widget.itemDetails['flying_time'].toString(),
                    //     price: widget.itemDetails['price'].toString(),
                    //   );

                    //   dataBaseHandler.saveflight(flight);
                    //   SnackBar snackBar = SnackBar(
                    //     content: Text(
                    //       'book ${flight.from} successfully',
                    //     ),
                    //     duration: const Duration(milliseconds: 500),
                    //   );
                    //   setState(() {});

                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // },
                    child: Text('Book Now', style: Styles.headlineStyle1),
                  ),
                ),
              ],
            ),
    );
  }
}
