import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp/onboarding_screen1.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Timer to display on screen
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // push navigator to display another screen on stack
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Onboarding_Screen1(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6392C9), Color(0x008EA0E7)],

            //   x coordinates: 0,0(up side)  1,0(upside)
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
                  'images/Baby_bloom.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text("BabyBloom",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.black.withOpacity(0.7599999904632568))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
