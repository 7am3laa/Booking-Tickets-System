import 'package:flutter/material.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/CustomForFlightCards/hotelcard.dart';
import 'package:projectf/constant.dart';

// ignore: must_be_immutable
class HotelScreen extends StatelessWidget {
  HotelScreen({super.key});
  List<Map<String, dynamic>> hotelList = hotelList1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotels"),
        backgroundColor: const Color.fromARGB(255, 1, 14, 25),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: hotelList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = hotelList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    itemDetails: item,
                    ishotel: true,
                  ),
                ),
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: HotelCard(
                  containerWidth: MediaQuery.of(context).size.width - 40,
                  containerHeight: 150,
                  hotelImage: item['image'],
                  hotelName: item['name'],
                  hotelPlace: item['place'],
                  nightPrice: item['price'],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
