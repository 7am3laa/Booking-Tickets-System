import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/homescreen.dart';
import 'package:projectf/Screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashscreen';
  final Users? user;
  const SplashScreen({this.user, super.key});
  void fetchingFlightsData() {}
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: (5000 / 100).round()), (timer) {
      setState(() {
        if (progressValue >= 1.0) {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(user: widget.user!),
            ),
          );
        } else {
          progressValue += 0.01;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double barWidth = screenWidth * 0.7; // 70% of screen width

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
            const SizedBox(height: 10.0),
            Stack(
              children: [
                Container(
                  width: barWidth,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: (5000 / 100).round()),
                  width: barWidth * progressValue,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                Positioned(
                  left: progressValue * barWidth -
                      10.0, // Adjust the position of the icon based on progress
                  top: 0.0,
                  child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: const Icon(
                      Icons.flight,
                      color: Colors.black,
                      size: 20.0,
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
