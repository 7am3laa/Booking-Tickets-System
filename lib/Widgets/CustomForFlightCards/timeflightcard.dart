import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/cardtext.dart';

// ignore: must_be_immutable
class TimeFlightCard extends StatelessWidget {
  String flightDate;
  String flightTime;
  String flightNumber;
  String airlineName;
  String airlineLogo;
  TimeFlightCard({
    required this.airlineName,
    required this.airlineLogo,
    required this.flightDate,
    required this.flightTime,
    required this.flightNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: Container(
            color: const Color(0xFFF37B67),
            width: 360,
            height: 110,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/airport3.png',
                        width: 40,
                        height: 40,
                      ),
                      Row(
                        children: [
                          CardText(
                              textContent: airlineName,
                              textColor: Colors.white,
                              fontSize: 18),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Image.network(
                              airlineLogo,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/airport4.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardText(
                          textContent: flightDate,
                          textColor: Colors.white,
                          fontSize: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: CardText(
                            textContent: flightTime,
                            textColor: Colors.white,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: CardText(
                            textContent: flightNumber,
                            textColor: Colors.white,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardText(
                          textContent: '   Date',
                          textColor: Colors.white,
                          fontSize: 20),
                      CardText(
                          textContent: 'Deprature Time',
                          textColor: Colors.white,
                          fontSize: 20),
                      CardText(
                          textContent: 'Number',
                          textColor: Colors.white,
                          fontSize: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
