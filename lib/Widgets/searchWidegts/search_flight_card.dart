import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:projectf/constant.dart';

class SeacrhFlightCard extends StatelessWidget {
  final String sourceName;
  final String sourceCode;
  final String destinationName;
  final String destinationCode;
  final String flightDate;
  final String flightTime;
  int? hoursOfFlightDuration;
  int? minutesOfFlightDuration;
  String? airline_logo;
  String? airline;
  String? flightNumber = '1';
  String? travelClass;
  List<dynamic>? extensions;
  final int price;

  SeacrhFlightCard(
      {required this.price,
      required this.flightDate,
      required this.flightTime,
      this.hoursOfFlightDuration,
      this.minutesOfFlightDuration,
      this.airline,
      this.airline_logo,
      this.flightNumber,
      this.extensions,
      this.travelClass,
      required this.sourceName,
      required this.sourceCode,
      required this.destinationName,
      required this.destinationCode,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Container(
        height: extensions != null && extensions!.isNotEmpty ? 400 : 230,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image.network(
                  airline_logo!,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          sourceName,
                          style: Styles.headlineStyle2.copyWith(fontSize: 20),
                        ),
                      ),
                      const Expanded(
                        child: Icon(Icons.arrow_forward, color: Colors.grey),
                      ),
                      Expanded(
                        child: Text(
                          destinationName,
                          style: Styles.headlineStyle2.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          sourceCode,
                          style: Styles.headlineStyle3.copyWith(fontSize: 20),
                        ),
                      ),
                      const Expanded(
                        child: Icon(Icons.arrow_forward, color: Colors.grey),
                      ),
                      Expanded(
                        child: Text(
                          destinationCode,
                          style: Styles.headlineStyle3.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Travel Class: $travelClass',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Departure Time: $flightTime',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Flying Time: ${hoursOfFlightDuration}H ${minutesOfFlightDuration}M',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Date: $flightDate',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Price: \$ $price',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  if (extensions != null && extensions!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Extensions:',
                          style: Styles.headlineStyle4.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        // Display each extension as a text widget
                        for (var extension in extensions!)
                          Text(
                            extension.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
