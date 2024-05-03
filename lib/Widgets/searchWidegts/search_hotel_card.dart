import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class SearchHotelCard extends StatelessWidget {
  final String image;
  final String place;
  final String destination;
  const SearchHotelCard(
      {super.key,
      required this.image,
      required this.place,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
              ),
            ),
          ],
        ),
        Text(
          place,
          style: Styles.headlineStyle1.copyWith(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        Text(
          destination,
          style: Styles.headlineStyle3.copyWith(),
        ),
      ],
    );
  }
}
