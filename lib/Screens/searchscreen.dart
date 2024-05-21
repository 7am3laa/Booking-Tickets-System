// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Cubits/Manage-ticketScreen-Cubit/manage_Ticket_screen_State.dart';
import 'package:projectf/Cubits/Manage-ticketScreen-Cubit/ticketscreen_cubit.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/searchWidegts/search/flight.dart';
import 'package:projectf/Widgets/searchWidegts/search/hotelsearch.dart';

import 'package:projectf/constant.dart';

class SearchScreen extends StatelessWidget {
  List<FlightModel>? ticketList = [];
  SearchScreen({Key? key, this.ticketList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => TicketScreenCubit(),
      child: BlocBuilder<TicketScreenCubit, TicketsState>(
        builder: (context, state) {
          if (state is FlightOrHotelState) {
            bool isSelected = state.isSelected;
            bool isHotel = state.isHotel;
            return Scaffold(
              backgroundColor: theme.brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
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
                          style: Styles.headlineStyle1.copyWith(
                              fontWeight: FontWeight.w900, fontSize: 35),
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
                                context
                                    .read<TicketScreenCubit>()
                                    .selectScreen(true, false);
                              },
                              child: Container(
                                width: AppLayout.getWidth(context) / 2.2,
                                height: 55,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color.fromARGB(238, 9, 7, 98)
                                      : Colors.grey.shade400,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    bottomLeft: Radius.circular(32),
                                  ),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Text(
                                    'Airplane Tickets',
                                    style: Styles.headlineStyle2.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade600),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<TicketScreenCubit>()
                                    .selectScreen(false, true);
                              },
                              child: Container(
                                width: AppLayout.getWidth(context) / 2.2,
                                height: 55,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.grey.shade300
                                      : const Color.fromARGB(238, 9, 7, 98),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(32),
                                    bottomRight: Radius.circular(32),
                                  ),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Center(
                                  child: Text(
                                    'Hotels',
                                    style: Styles.headlineStyle2.copyWith(
                                      color: isSelected
                                          ? Colors.grey.shade600
                                          : Colors.white,
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
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(238, 9, 7, 98),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Gap(25),
                                          const Icon(
                                            Icons.hotel_class,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Five Stars',
                                            style: const TextStyle(
                                                    color: Colors.white)
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 23),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(25),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(238, 9, 7, 98),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Gap(25),
                                          const Icon(
                                            Icons.hotel_class,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Four Stars',
                                            style: const TextStyle(
                                                    color: Colors.white)
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 23),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(238, 9, 7, 98),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Gap(25),
                                          const Icon(
                                            Icons.flight_takeoff,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Departure',
                                            style: const TextStyle(
                                                    color: Colors.white)
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 23),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(25),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(238, 9, 7, 98),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Gap(25),
                                          const Icon(
                                            Icons.flight_land,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          const Gap(25),
                                          Text(
                                            'Arrival',
                                            style: const TextStyle(
                                                    color: Colors.white)
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 23),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
                child: Button(
                  onTap: () {
                    isHotel
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchHotelPage(),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchFlightPage(
                                ticketList: ticketList,
                              ),
                            ),
                          );
                  },
                  text: 'Find Tickets',
                  color: const Color.fromARGB(238, 9, 7, 98),
                  textColor: Colors.white,
                  width: AppLayout.getWidth(context),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
