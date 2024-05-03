import 'package:flutter/material.dart';

Color primary = const Color(0xFF687daf);

class Styles {
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFeeedf2);
  static Color orangeColor = const Color(0xFFF37B67);
  static Color kakiColor = const Color(0xFFd2bdb6);
  static TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: textColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineStyle1 = TextStyle(
    fontFamily: 'pa',
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineStyle2 = TextStyle(
    fontFamily: 'pa',
    fontSize: 21,
    color: textColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineStyle3 = TextStyle(
    fontFamily: 'pa',
    fontSize: 17,
    color: textColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headlineStyle4 = TextStyle(
    fontFamily: 'pa',
    fontSize: 14,
    color: Colors.grey.shade500,
    fontWeight: FontWeight.w500,
  );
}

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getThemeMode(BuildContext context) {
    return Theme.of(context).brightness;
  }
}

List<Map<String, dynamic>> ticketList = [
  {
    'from': {'code': "NYC", 'name': "New-York"},
    'to': {'code': "LDN", 'name': "London"},
    'flying_time': '8H 30M',
    'date': "1 MAY",
    'departure_time': "08:00 AM",
    "number": 23,
    "price": 100
  },
  {
    'from': {'code': "DK", 'name': "Dhaka"},
    'to': {'code': "SH", 'name': "Shanghai"},
    'flying_time': '4H 20M',
    'date': "10 MAY",
    'departure_time': "09:00 AM",
    "number": 45,
    "price": 200
  },
  {
    'from': {'code': "NYC", 'name': "EGYPT"},
    'to': {'code': "LDN", 'name': "London"},
    'flying_time': '8H 30M',
    'date': "1 MAY",
    'departure_time': "08:00 AM",
    "number": 23,
    "price": 100
  },
  {
    'from': {'code': "DK", 'name': "Dhaka"},
    'to': {'code': "SH", 'name': "Shanghai"},
    'flying_time': '4H 20M',
    'date': "10 MAY",
    'departure_time': "09:00 AM",
    "number": 45,
    "price": 200
  },
];
List<Map<String, dynamic>> hotelList = [
  {
    'image': 'one.png',
    'place': 'Open Space',
    'destination': 'London',
    'price': 25
  },
  {
    'image': 'two.png',
    'place': 'Global Will',
    'destination': 'London',
    'price': 40
  },
  {
    'image': 'three.png',
    'place': 'Tallest Building',
    'destination': 'Dubai',
    'price': 68
  },
];
