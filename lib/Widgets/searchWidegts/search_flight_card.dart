import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/constant.dart';

class SeacrhFlightCard extends StatelessWidget {
  final String source;
  final String destination;
  final String departureTime;
  final String flightDuration;
  final String price;
  final String date;
  final String sourceCode;
  final String destinationCode;

  const SeacrhFlightCard({
    Key? key,
    required this.departureTime,
    required this.flightDuration,
    required this.price,
    required this.date,
    required this.source,
    required this.destination,
    required this.destinationCode,
    required this.sourceCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Container(
        height: 240,
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
            const Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 35,
                child: Icon(
                  Icons.flight,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          source,
                          style: Styles.headlineStyle2.copyWith(fontSize: 20),
                        ),
                      ),
                      const Expanded(
                        child: Icon(Icons.arrow_forward, color: Colors.grey),
                      ),
                      Expanded(
                        child: Text(
                          destination,
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
                  const SizedBox(height: 2.0),
                  Text(
                    'Departure Time: $departureTime',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Flying Time: $flightDuration',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Date: $date',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Price: \$ $price',
                    style: Styles.headlineStyle4.copyWith(fontSize: 20),
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
