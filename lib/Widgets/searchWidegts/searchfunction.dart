import 'package:flutter/material.dart';
import 'package:projectf/API/fetchFlights.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class SearchResults extends SearchDelegate<String> {
  Users? users;
  final bool isHotel;
  SearchResults({required this.isHotel, this.users});

  List filteredList = [];
  FetchFlights fetchFlights = FetchFlights();
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
    DataSet dataSet = DataSet();
    final List<Map<String, dynamic>> list =
        isHotel ? dataSet.hotelList : dataSet.ticketList;

    if (query.isEmpty) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return buildListItem(context, item);
        },
      );
    } else {
      filteredList = list.where((element) {
        if (isHotel) {
          return element['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['place']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        } else {
          return element['from']['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['to']['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }
      }).toList();
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
            builder: (context) => DetailsScreen(
              users: users,
              itemDetails: item,
              ishotel: isHotel,
            ),
          ),
        );
      },
      child: ListTile(
        title: isHotel
            ? SearchHotelCard(
                image: 'assets/images/hotels/${item['image']}',
                place: item['name'].toString(),
                destination: item['place'].toString(),
              )
            : SeacrhFlightCard(
                sourceCode: item['from']['code'].toString(),
                destinationCode: item['to']['code'].toString(),
                source: item['from']['name'].toString(),
                destination: item['to']['name'].toString(),
                date: item['date'].toString(),
                departureTime: item['departure_time'].toString(),
                flightDuration: item['flying_time'].toString(),
                price: item['price'].toString(),
              ),
      ),
    );
  }
}
