import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/placeflightcard.dart';
import 'package:projectf/Widgets/CustomForFlightCards/timeflightcard.dart';

// ignore: must_be_immutable
class FullTicketCard extends StatelessWidget {
  String sourceName;
  String sourceCode;
  String destinationName;
  String destinationCode;
  int flyingTime;
  String flightDate;
  String flightTime;
  String flightNumber;
  String airlineName;
  String airlineLogo;
  FullTicketCard(
      {required this.airlineName,
      required this.airlineLogo,
      required this.flightDate,
      required this.flightTime,
      required this.flightNumber,
      required this.sourceName,
      required this.sourceCode,
      required this.destinationName,
      required this.destinationCode,
      required this.flyingTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlaceFlightCard(
            sourceName: sourceName,
            sourceCode: sourceCode,
            destinationName: destinationName,
            destinationCode: destinationCode,
            flyingTime: flyingTime),
        TimeFlightCard(
          airlineLogo: airlineLogo,
          airlineName: airlineName,
          flightDate: flightDate,
          flightTime: flightTime,
          flightNumber: flightNumber,
        )
      ],
    );
  }
}
