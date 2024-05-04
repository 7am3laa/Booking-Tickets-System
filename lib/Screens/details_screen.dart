import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> itemDetails;

  const DetailsScreen({Key? key, required this.itemDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/${itemDetails['image']}'),
            Text(
              'Place: ${itemDetails['place']}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Destination: ${itemDetails['destination']}',
              style: const TextStyle(fontSize: 20),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
