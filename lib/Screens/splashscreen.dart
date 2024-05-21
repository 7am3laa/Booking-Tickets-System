// ignore_for_file: must_be_immutable, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectf/API/fetchFlights.dart';
import 'package:projectf/API/flightModel.dart';
import 'package:projectf/Screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashscreen';
  List<FlightModel>? ticketList = [];
  List<FlightModel>? flightList = [];
  SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0.0;
  bool apiLoaded = false;
  List<FlightModel>? flightList;

  @override
  void initState() {
    super.initState();
    startTimer();
    fetchingFlightsData();
  }

  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (progressValue >= 1.0) {
          if (!apiLoaded) {
            timer.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                    isloaded: apiLoaded, ticketList: widget.ticketList),
              ),
            );
          } else {
            timer.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                    isloaded: apiLoaded, ticketList: widget.ticketList),
              ),
            );
          }
        } else {
          progressValue += 0.01;
        }
      });
    });
  }

  void fetchingFlightsData() async {
    try {
      flightList = await FetchFlights().getNews();
      print('Flight list is $flightList');
      widget.ticketList = flightList;
    } catch (error) {
      print('Error fetching flights data: $error');
      widget.ticketList = [];
    } finally {
      setState(() {
        apiLoaded = true;
        progressValue = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${(progressValue * 100).round()}%',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 10.0,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Positioned(
                  child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: const Icon(
                      Icons.flight,
                      color: Colors.black,
                      size: 40.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
