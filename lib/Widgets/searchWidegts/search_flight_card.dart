import 'package:flutter/material.dart';
import 'package:projectf/constant.dart';

class SeacrhFlightCard extends StatelessWidget {
  final String from;
  final String to;
  final String departureTime;
  final String flightDuration;
  final String price;

  const SeacrhFlightCard(
      {super.key,
      required this.from,
      required this.to,
      required this.departureTime,
      required this.flightDuration,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        tileColor: Colors.white,
        onTap: () {},
        leading: const CircleAvatar(
          child: Icon(
            Icons.flight,
            weight: 100,
            size: 30,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    from,
                    style: Styles.headlineStyle2.copyWith(fontSize: 20),
                  ),
                ),
                const Expanded(
                    child: Icon(Icons.arrow_forward, color: Colors.grey)),
                Expanded(
                  child: Text(
                    to,
                    style: Styles.headlineStyle2.copyWith(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
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
              'Price: \$ $price',
              style: Styles.headlineStyle4.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
