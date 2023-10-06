import 'package:flutter/material.dart';
import 'package:fyp/colors.dart';
import 'package:fyp/menu_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class Onboarding_Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        color: Onboardcolor1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
                image: AssetImage('assets/images/On-board-pic2.png'),
                width: 500,
                height: 300),
            // const SizedBox(
            //   height: 1,
            // ),
            Text(
              'In app consultation',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.30,
                  color: Colors.black.withOpacity(0.75999)),
            ),
            SizedBox(height: 10),
            // Padding(padding: EdgeInsets.only(top: 5)),

            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: -0.30,
                  color: Color(0xE5677294)),
            ),
            SizedBox(height: 70),
            ElevatedButton1(),
          ],
        ),
      ),
    );
  }
}

class ElevatedButton1 extends StatefulWidget {
  const ElevatedButton1({super.key});

  @override
  State<ElevatedButton1> createState() => _ElevatedButton1();
}

class _ElevatedButton1 extends State<ElevatedButton1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: bluestyle,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(),
                  ));
            },
            child: const Text('Get Started'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

final ButtonStyle bluestyle = ElevatedButton.styleFrom(
  padding: (EdgeInsets.fromLTRB(100, 20, 100, 20)),
  textStyle:
      GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w600, height: 0),
  backgroundColor: Color(0xff374366),
  foregroundColor: Colors.white,
);
