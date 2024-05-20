// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/homescreen.dart';
import 'package:projectf/Screens/profilescreen.dart';
import 'package:projectf/Screens/searchscreen.dart';
import 'package:projectf/Screens/ticketsscreen.dart';

class MainScreen extends StatefulWidget {
  final Users? user;
  List<FlightModel>? ticketList = [];
  MainScreen({Key? key, this.user, this.ticketList}) : super(key: key);
  static const String id = 'mainscreen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late List<Widget> _bodyScreens;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _updateBodyScreens();
  }

  void _updateBodyScreens() {
    _bodyScreens = [
      HomeScreen(ticketList: widget.ticketList),
      SearchScreen(ticketList: widget.ticketList!),
      TicketsScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: _bodyScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTapItem,
        elevation: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor:
            theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: theme.brightness == Brightness.dark
            ? Colors.grey
            : Colors.grey[500],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            activeIcon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            activeIcon: Icon(Icons.search_outlined),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_rounded),
            activeIcon: Icon(Icons.airplane_ticket_outlined),
            label: "ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_3_sharp),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
