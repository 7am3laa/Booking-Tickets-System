import 'package:flutter/material.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Screens/details_screen.dart';
import 'package:projectf/Widgets/searchWidegts/search_flight_card.dart';
import 'package:projectf/Widgets/searchWidegts/search_hotel_card.dart';
import 'package:projectf/constant.dart';

class SearchResults extends SearchDelegate<String> {
  final bool isHotel;
  List<FlightModel>? ticketList = [];
  SearchResults({required this.isHotel, this.ticketList});

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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.5,
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sorry...!',
                style: Styles.headlineStyle2.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'pa'),
              ),
            ),
          ],
        ),
      ),
      content: Text(
        'We have No ${isHotel ? 'Hotels' : 'Flights'} For You',
        style: Styles.headlineStyle2.copyWith(
            fontSize: 22, fontWeight: FontWeight.w800, fontFamily: 'pa'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildList(isHotel, query, context);
  }

  Widget buildList(bool isHotel, String query, BuildContext context) {
    DataSet dataSet = DataSet();
    List<Map<String, dynamic>> list = [];
    if (isHotel) {
      list = dataSet.hotelList;
    } else {
      for (var flight in ticketList!) {
        Map<String, dynamic> flightMap = {
          'arrivalAirportName': flight.arrivalAirportName,
          'arrivalAirportId': flight.arrivalAirportId,
          'arrivalTime': flight.arrivalTime,
          'flightNumber': flight.flightNumber,
          'departureAirportName': flight.departureAirportName,
          'departureAirportId': flight.departureAirportId,
          'departureTime': flight.departureTime,
          'price': flight.price,
          'airline': flight.airline,
          'airlineLogo': flight.airlineLogo,
          'hoursOfFlightDuration': flight.hoursOfFlightDuration,
          'minutesOfFlightDuration': flight.minutesOfFlightDuration,
          'extensions': flight.extensions,
          'travelClass': flight.travelClass,
        };
        list.add(flightMap);
      }
    }

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
          return element['departureAirportName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['arrivalAirportName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['travelClass']
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
                name: item['name'].toString(),
                place: item['place'].toString(),
                price: item['price'].toString(),
              )
            : SeacrhFlightCard(
                sourceName: item['departureAirportName'], //1
                sourceCode: item['departureAirportId'], //2
                destinationName: item['arrivalAirportName'], //3
                destinationCode: item['arrivalAirportId'], //4
                hoursOfFlightDuration: item['hoursOfFlightDuration'], //11
                minutesOfFlightDuration: item['minutesOfFlightDuration'], //5
                flightDate: item['departureTime'].split(' ')[0], //5
                flightTime: item['departureTime'].split(' ')[1], //6
                flightNumber: item['flightNumber'],
                airline: item['airline'],
                airline_logo: item['airlineLogo'], //8
                price: item['price'], //9
                travelClass: item['travelClass'], //10
              ),
      ),
    );
  }
}
