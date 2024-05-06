// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Widgets/searchWidegts/searchfunction.dart';
import 'package:projectf/constant.dart';

class SearchScreen extends StatefulWidget {
  Users? users;
  List<FlightModel>? ticketList = [];
  SearchScreen({Key? key, this.users, this.ticketList}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isHotel = false;
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : Colors.white,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'What are\nYou  looking  for?',
                  style: Styles.headlineStyle1
                      .copyWith(fontWeight: FontWeight.w900, fontSize: 35),
                ),
              ),
              const Gap(25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                          color:
                              isSelected ? Colors.white : Colors.grey.shade300,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            bottomLeft: Radius.circular(32),
                          ),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Center(
                          child: Text(
                            'Airplane Tickets',
                            style: Styles.headlineStyle2.copyWith(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade600,
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
                          color:
                              isSelected ? Colors.grey.shade300 : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Center(
                          child: Text(
                            'Hotels',
                            style: Styles.headlineStyle2.copyWith(
                              color: isSelected
                                  ? Colors.grey.shade600
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(25),
              SizedBox(
                child: isHotel
                    ? SizedBox(
                        child: Center(
                            child: Text(
                                'Hotels Five Stars \n         In All Cities',
                                style: Styles.headlineStyle3.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25))),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Gap(25),
                                  const Icon(
                                    Icons.flight_takeoff,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  const Gap(25),
                                  Text(
                                    'Departure',
                                    style: Styles.headlineStyle3.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(25),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Gap(25),
                                  const Icon(
                                    Icons.flight_land,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  const Gap(25),
                                  Text(
                                    'Arrival',
                                    style: Styles.headlineStyle3.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
        child: InkWell(
          onTap: () {
            showSearch(
                context: context,
                delegate: SearchResults(
                    users: widget.users,
                    isHotel: isHotel,
                    ticketList: widget.ticketList));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 70,
            child: Center(
              child: Text(
                'Find Tickets',
                style: Styles.headlineStyle1.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
