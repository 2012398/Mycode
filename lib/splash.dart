import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp/onboarding_screen1.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Timer to display on screen
    super.initState();
    Timer(Duration(seconds: 2), () {
      // push navigator to display another screen on stack
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Onboarding_Screen1(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6392C9), Color(0x008EA0E7)],

            //   x cordinates: 0,0(up side)  1,0(upside)
            //   y coordinates:0,1(down side) 1,1(downside)
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/Baby_bloom.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "BabyBloom",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      height: 0,
                      letterSpacing: -0.30,
                      color: Colors.black.withOpacity(0.75999)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
