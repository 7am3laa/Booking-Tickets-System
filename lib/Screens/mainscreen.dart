// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Screens/homescreen.dart';
import 'package:projectf/Screens/profilescreen.dart';
import 'package:projectf/Screens/searchscreen.dart';
import 'package:projectf/Screens/ticketsscreen.dart';

class MainScreen extends StatefulWidget {
  List<FlightModel>? ticketList = [];
  final bool? isloaded;
  MainScreen({Key? key, this.ticketList, this.isloaded}) : super(key: key);
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
      HomeScreen(isloaded: widget.isloaded, ticketList: widget.ticketList),
      SearchScreen(ticketList: widget.ticketList!),
      const TicketsScreen(),
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
        selectedItemColor:
            theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: theme.brightness == Brightness.dark
            ? Colors.grey
            : Colors.grey[500],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            activeIcon: Icon(LineIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.search),
            activeIcon: Icon(LineIcons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.alternateTicket),
            activeIcon: Icon(LineIcons.alternateTicket),
            label: "Ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            activeIcon: Icon(LineIcons.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
