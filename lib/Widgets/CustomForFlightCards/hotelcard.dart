import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/cardtext.dart';

class HotelCard extends StatelessWidget {
  String hotelName;
  String hotelPlace;
  String hotelImage;
  int nightPrice;
  final double containerWidth;
  final double containerHeight;
  HotelCard({
    required this.containerHeight,
    required this.containerWidth,
    required this.hotelImage,
    required this.hotelName,
    required this.hotelPlace,
    required this.nightPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              width: containerWidth,
              height: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(
                  'assets/images/hotels/$hotelImage',
                  width: containerWidth,
                  height: containerHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                color: const Color(0xFF787DAF),
                width: containerWidth,
                height: containerHeight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardText(
                          textContent: hotelName,
                          textColor: Colors.white,
                          fontSize: 30),
                      const SizedBox(
                        height: 10,
                      ),
                      CardText(
                          textContent: hotelPlace,
                          textColor: const Color.fromARGB(170, 255, 255, 255),
                          fontSize: 20),
                      const SizedBox(
                        height: 10,
                      ),
                      CardText(
                        textContent: "$nightPrice\$/NIGHT",
                        textColor: const Color.fromARGB(255, 100, 235, 105),
                        fontSize: 25,
                        textWeight: 'Yes',
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
          width: 20,
        ),
      ],
    );
  }
}
