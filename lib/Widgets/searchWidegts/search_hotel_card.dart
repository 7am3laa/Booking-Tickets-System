import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class SearchHotelCard extends StatelessWidget {
  final String image;
  final String name;
  final String place;
  final String price;
  const SearchHotelCard(
      {super.key,
      required this.image,
      required this.place,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, blurRadius: 5, offset: Offset.zero),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Styles.headlineStyle1.copyWith(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      place,
                      style: Styles.headlineStyle3.copyWith(),
                    ),
                    Text(
                      '\$ $price / night',
                      style: Styles.headlineStyle3.copyWith(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
