import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/cardtext.dart';

// ignore: must_be_immutable
class PlaceFlightCard extends StatelessWidget {
  String sourceName;
  String sourceCode;
  String destinationName;
  String destinationCode;
  int flyingTime;

  PlaceFlightCard({
    required this.sourceName,
    required this.sourceCode,
    required this.destinationName,
    required this.destinationCode,
    required this.flyingTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            color: const Color.fromARGB(255, 15, 92, 154),
            width: 360,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 20, bottom: 10, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardText(
                        textContent: sourceCode,
                        textColor: Colors.white,
                        fontSize: 20,
                        textWeight: 'Yes',
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5.0,
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(
                              Icons.circle,
                              color: Color.fromARGB(255, 10, 91, 158),
                              size: 12,
                            ),
                          ),
                          CardText(
                              textContent: '- - - - ',
                              textColor: Colors.white,
                              fontSize: 16),
                          Transform.rotate(
                            angle: 90 * pi / 180,
                            child: const Icon(
                              Icons.flight,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          CardText(
                              textContent: '- - - - ',
                              textColor: Colors.white,
                              fontSize: 16),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5.0,
                                color: Colors.white,
                              ),
                            ),
                            child: const Icon(
                              Icons.circle,
                              color: Color.fromARGB(255, 10, 91, 158),
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      CardText(
                        textContent: destinationCode,
                        textColor: Colors.white,
                        fontSize: 20,
                        textWeight: 'Yes',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardText(
                          textContent: sourceName,
                          textColor: Colors.white,
                          fontSize: 18),
                      CardText(
                          textContent:
                              '${(flyingTime / 60).floor()}H ${flyingTime % 60}M',
                          textColor: Colors.white,
                          fontSize: 18),
                      CardText(
                          textContent: destinationName,
                          textColor: Colors.white,
                          fontSize: 18),
                    ],
                  ),
                ],
              ),
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
