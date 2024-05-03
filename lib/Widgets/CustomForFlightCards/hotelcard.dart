import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/cardtext.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.asset(
            'assets/images/hotel1.png',
            width: 300,
          ),
        ),
        Container(
          color: const Color(0xFF787DAF),
          width: 300,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardText(
                    textContent: 'Open Space',
                    textColor: Colors.white,
                    fontSize: 30),
                const SizedBox(
                  height: 10,
                ),
                CardText(
                    textContent: 'London',
                    textColor: const Color.fromARGB(170, 255, 255, 255),
                    fontSize: 20),
                const SizedBox(
                  height: 10,
                ),
                CardText(
                  textContent: "20\$/NIGHT",
                  textColor: const Color.fromARGB(255, 100, 235, 105),
                  fontSize: 25,
                  textWeight: 'Yes',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
