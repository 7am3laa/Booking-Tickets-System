import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/cardtext.dart';

class TimeFlightCard extends StatelessWidget {
  String flightDate;
  String flightTime;
  int flightNumber;
  TimeFlightCard({
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
                    children: [
                      Transform.rotate(
                        angle: 90 * 3.141592653589793 / 180,
                        child: const Icon(
                          Icons.shield,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      CardText(
                          textContent:
                              '- - - - - - - - - - - - - - - - - - - - - - -',
                          textColor: Colors.white,
                          fontSize: 20),
                      Transform.rotate(
                        angle: 270 * 3.141592653589793 / 180,
                        child: const Icon(
                          Icons.shield,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            textContent: flightDate,
                            textColor: Colors.white,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: CardText(
                            textContent: '$flightNumber',
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
                          textContent: ' Date',
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
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
