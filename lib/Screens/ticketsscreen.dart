import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';

import 'package:projectf/DataBase/user.dart';
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
  DataBaseHandler dataBaseHandler = DataBaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: FutureBuilder(
        future: dataBaseHandler.getHotelsForUser(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<Hotel> hotels = snapshot.data!;
            if (hotels.isEmpty) {
              return const Center(
                  child: Text(
                'No Tickets',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ));
            } else {
              return ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10,
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
                          SearchHotelCard(
                            image: 'assets/images/${hotels[index].image}',
                            place: hotels[index].place!,
                            destination: hotels[index].destination!,
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${hotels[index].numOfTickets.toString()} Tickets',
                                  style: Styles.headlineStyle2.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Delete Ticket'),
                                            content: const Text(
                                                'Are you sure you want to delete this ticket?'),
                                            actions: [
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                   
                                                      
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.red,
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
    );
  }
}
