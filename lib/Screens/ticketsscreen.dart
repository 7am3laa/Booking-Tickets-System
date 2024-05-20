// ignore_for_file: use_build_context_synchronously, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:projectf/Cubits/Manage-ticketScreen-Cubit/manage_Ticket_screen_State.dart';
import 'package:projectf/Cubits/Manage-ticketScreen-Cubit/ticketscreen_cubit.dart';
import 'package:projectf/Cubits/User-cubit/user-cubit.dart';
import 'package:projectf/Cubits/flight-Cubit/flight_cubit.dart';
import 'package:projectf/Cubits/flight-Cubit/flight_state.dart';
import 'package:projectf/Cubits/hotels-Cubit/hotel_cubit.dart';
import 'package:projectf/Cubits/hotels-Cubit/hotel_state.dart';

import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    Key? key,
  }) : super(key: key);

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
      body: BlocProvider(
        create: (context) => TicketScreenCubit(),
        child: BlocBuilder<TicketScreenCubit, TicketsState>(
            builder: (context, state) {
          if (state is FlightOrHotelState) {
            bool isSelected = state.isSelected;
            bool isHotel = state.isHotel;
            return Column(
              children: [
                Row(
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
                            'Flights Booked',
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
                        context
                            .read<TicketScreenCubit>()
                            .selectScreen(false, true);
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
                            'Hotels Booked',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: isHotel
                        ? BlocProvider(
                            create: (context) => HotelCubit()
                              ..getHotelsForUser(
                                  context.read<UserCubit>().loggedInuser!.id),
                            child: BlocBuilder<HotelCubit, HotelState>(
                              builder: (context, state) {
                                if (state is LoadingHotelState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is LoadedHotelState) {
                                  return ListView.builder(
                                    itemCount: state.hotel.length,
                                    itemBuilder: (context, index) {
                                      var data = state.hotel[index];
                                      print('${data.id} + $index');
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              SearchHotelCard(
                                                image:
                                                    'assets/images/hotels/${data.image}',
                                                name: data.place.toString(),
                                                place:
                                                    data.destination.toString(),
                                                price: data.pricehotel!,
                                              ),
                                              const Gap(10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\$ ${data.totalPrice!} / ${data.numOfTickets!} nights',
                                                      style: Styles
                                                          .headlineStyle3
                                                          .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _showDialog(context,
                                                            () {
                                                          BlocProvider.of<
                                                                      HotelCubit>(
                                                                  context)
                                                              .deleteHotelForUser(
                                                                  data.id!,
                                                                  context
                                                                      .read<
                                                                          UserCubit>()
                                                                      .loggedInuser!
                                                                      .id!);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                        size: 25,
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
                                } else if (state is EmptyHotelState) {
                                  return Center(
                                      child: Text(
                                    state.message,
                                    style: Styles.headlineStyle2,
                                  ));
                                } else if (state is ErrorHotelState) {
                                  return Text(
                                      'Some Thing Went Wrong : ${state.errorMessage}');
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          )
                        : BlocProvider(
                            create: (context) => FlightCubit()
                              ..getFlightsForUser(
                                  context.read<UserCubit>().loggedInuser!.id),
                            child: BlocBuilder<FlightCubit, FlightState>(
                              builder: (context, state) {
                                if (state is LoadingFlightState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedFlightState) {
                                  return ListView.builder(
                                    itemCount: state.flight.length,
                                    itemBuilder: (context, index) {
                                      var data = state.flight[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              SeacrhFlightCard(
                                                sourceCode:
                                                    data.sourceCode.toString(),
                                                destinationCode: data
                                                    .destinationCode
                                                    .toString(),
                                                sourceName:
                                                    data.sourceName.toString(),
                                                destinationName: data
                                                    .destinationName
                                                    .toString(),
                                                flightDate:
                                                    data.flightDate.toString(),
                                                flightTime:
                                                    data.flightTime.toString(),
                                                hoursOfFlightDuration:
                                                    data.hoursOfFlightDuration!,
                                                minutesOfFlightDuration: data
                                                    .minutesOfFlightDuration!,
                                                airline_logo: data.airlineLogo!,
                                                price: data.price!,
                                                travelClass: data.travelClass!,
                                              ),
                                              const Gap(10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\$ ${data.toatalFlightPrice} / ${data.numOfTickets!} Flight Ticktets',
                                                      style: Styles
                                                          .headlineStyle3
                                                          .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _showDialog(context,
                                                            () {
                                                          BlocProvider.of<
                                                                      FlightCubit>(
                                                                  context)
                                                              .deleteFlightForUser(
                                                                  data.id!,
                                                                  context
                                                                      .read<
                                                                          UserCubit>()
                                                                      .loggedInuser!
                                                                      .id!);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.red),
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
                                } else if (state is EmptyFlightState) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style: Styles.headlineStyle2,
                                    ),
                                  );
                                } else if (state is ErrorFlightState) {
                                  return Text(
                                      'Some Thing Went Wrong : ${state.errorMessage}');
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

void _showDialog(BuildContext context, Function() onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm',
          style: Styles.headlineStyle1,
        ),
        content: Text(
          'Are you sure you want to delete this Ticket?',
          style: Styles.headlineStyle2,
        ),
        actions: [
          Button(
            onTap: onTap,
            text: 'Delete',
            color: Colors.red,
            textColor: Colors.white,
            width: 1,
          ),
          const SizedBox(
            height: 15,
          ),
          Button(
            onTap: () {
              Navigator.pop(context);
            },
            text: 'Cancel',
            color: Colors.white,
            textColor: Colors.black,
            width: 1,
          ),
        ],
      );
    },
  );
}
