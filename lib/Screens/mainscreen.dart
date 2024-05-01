import 'package:flutter/material.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/profilescreen.dart';
import 'package:projectf/constant.dart';

class MainScreen extends StatefulWidget {
  final Users user;
  const MainScreen({Key? key, required this.user}) : super(key: key);
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
      Center(
        child: Text(
          'Home',
          style: Styles.headlineStyle1.copyWith(color: Colors.white),
        ),
      ),
      Center(
        child: Text(
          'Search',
          style: Styles.headlineStyle1.copyWith(color: Colors.white),
        ),
      ),
      Center(
        child: Text(
          'Tickets',
          style: Styles.headlineStyle1.copyWith(color: Colors.white),
        ),
      ),
      ProfileScreen(user: widget.user),
    ];
  }

  void _onTapItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0072FF), Color(0xFF00C6FF)],
          ),
        ),
        child: _bodyScreens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapItem,
        elevation: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xff526480),
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
            activeIcon: Icon(Icons.person_3_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
