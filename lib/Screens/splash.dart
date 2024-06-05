// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/admin_screen.dart';
import 'package:fyp/Screens/doctor_screen.dart';
import 'package:fyp/Screens/menu_screen1.dart';
import 'package:fyp/Screens/onboarding_screen1.dart';
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
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuScreen1(),
              ),
            );
          } else if (documentSnapshot.get('role') == 'doctor') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScreen(),
              ),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Onboarding_Screen1(),
            ),
          );
        }
      } catch (error) {
        print('Error fetching user document: $error');
        // Handle the error, e.g., show an error message or navigate to an error screen.
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Onboarding_Screen1(),
        ),
      );
      // Handle the case when the user is not authenticated.
      // You might want to navigate to a login screen or handle it differently.
    }
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
                  'assets/images/Baby_bloom.png',
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
