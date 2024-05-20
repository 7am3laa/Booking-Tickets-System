// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Cubits/search_cubits/fligth_search_cubit/flight_search_cubit.dart';
import 'package:projectf/Cubits/search_cubits/fligth_search_cubit/flight_search_state.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/constant.dart';

class SearchFlightPage extends StatelessWidget {
  List<FlightModel>? ticketList = [];
  SearchFlightPage({Key? key, this.ticketList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listf = [];
    for (var flight in ticketList!) {
      Map<String, dynamic> flightMap = {
        'arrivalAirportName': flight.arrivalAirportName,
        'arrivalAirportId': flight.arrivalAirportId,
        'arrivalTime': flight.arrivalTime,
        'flightNumber': flight.flightNumber,
        'departureAirportName': flight.departureAirportName,
        'departureAirportId': flight.departureAirportId,
        'departureTime': flight.departureTime,
        'price': flight.price,
        'airline': flight.airline,
        'airlineLogo': flight.airlineLogo,
        'hoursOfFlightDuration': flight.hoursOfFlightDuration,
        'minutesOfFlightDuration': flight.minutesOfFlightDuration,
        'extensions': flight.extensions,
        'travelClass': flight.travelClass,
      };
      listf.add(flightMap);
    }

    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => FlightSearchCubit(listf),
          child: const SearchPageContent(),
        ),
      ),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextField(
              style: Styles.headlineStyle1.copyWith(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search',
                hintStyle: Styles.headlineStyle1.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                context.read<FlightSearchCubit>().search(value);
              },
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<FlightSearchCubit, FlightSearchState>(
            builder: (context, state) {
              if (state is InitialFlightSearchState) {
                return buildFlightList(state.ticketList);
              } else if (state is SearchingFlightSearchState) {
                return buildFlightList(state.ticketList);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

Widget buildFlightList(List<Map<String, dynamic>> ticketList) {
  return ListView.builder(
    itemCount: ticketList.length,
    itemBuilder: (context, index) {
      Map<String, dynamic> item = ticketList[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  itemDetails: item,
                  ishotel: false,
                ),
              ),
            );
          },
          child: SeacrhFlightCard(
            sourceName: item['departureAirportName'],
            sourceCode: item['departureAirportId'],
            destinationName: item['arrivalAirportName'],
            destinationCode: item['arrivalAirportId'],
            hoursOfFlightDuration: item['hoursOfFlightDuration'],
            minutesOfFlightDuration: item['minutesOfFlightDuration'],
            flightDate: item['departureTime'].split(' ')[0],
            flightTime: item['departureTime'].split(' ')[1],
            flightNumber: item['flightNumber'],
            airline: item['airline'],
            airline_logo: item['airlineLogo'],
            price: item['price'],
            travelClass: item['travelClass'],
          ),
        ),
      );
    },
  );
}
