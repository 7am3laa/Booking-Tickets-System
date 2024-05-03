import 'package:flutter/material.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class SearchResults extends SearchDelegate<String> {
  final bool isHotel;
  SearchResults({required this.isHotel});

  List filteredList = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null.toString());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      query,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildList(isHotel, query, context);
  }

  Widget buildList(bool isHotel, String query, BuildContext context) {
    final List<Map<String, dynamic>> list = isHotel ? hotelList : ticketList;

    if (query.isEmpty) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return buildListItem(context, item);
        },
      );
    } else {
      isHotel ? filteredList = list : filteredList = list;
       filteredList = list
          .where((element) =>
              element['place']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['destination']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return buildListItem(context, item);
        },
      );
    }
    
  }

  Widget buildListItem(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(itemDetails: item),
          ),
        );
      },
      child: ListTile(
        title: isHotel
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: SearchHotelCard(
                  image: 'assets/images/${item['image']}',
                  place: item['place'].toString(),
                  destination: item['destination'].toString(),
                ),
              )
            : SeacrhFlightCard(
                from: item['from']['name'].toString(),
                to: item['to']['name'].toString(),
                departureTime: item['departure_time'].toString(),
                flightDuration: item['flying_time'].toString(),
                price: item['price'].toString(),
              ),
      ),
    );
  }
}
