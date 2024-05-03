import 'package:flutter/material.dart';
import 'package:projectf/Widgets/CustomForFlightCards/hotelcard.dart';
import 'package:projectf/constant.dart';

class HotelScreen extends StatelessWidget {
  HotelScreen({super.key});
  List<Map<String, dynamic>> hotelList = DataSet().hotelList;

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
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: HotelCard(
                containerWidth: MediaQuery.of(context).size.width - 50,
                containerHeight: 180,
                hotelImage: item['image'],
                hotelName: item['name'],
                hotelPlace: item['place'],
                nightPrice: item['price'],
              ),
            ),
          );
        },
      ),
    );
  }
}
