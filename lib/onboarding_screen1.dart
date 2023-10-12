import 'package:flutter/material.dart';
import 'package:fyp/colors.dart';
import 'package:fyp/onboarding_screen2.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding_Screen1 extends StatelessWidget {
  const Onboarding_Screen1({super.key});
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage('images/On-board-pic1.png'),
                width: 400,
                height: 400),

            // const SizedBox(
            //   height: 100,
            // ),
            Text(
              'Find Trusted Doctors',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.30,
                  color: Colors.black.withOpacity(0.75999)),
            ),
            const SizedBox(height: 10),
            // Padding(padding: EdgeInsets.only(top: 5)),

            Text(
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: -0.30,
                    color: const Color(0xE5677294))),
            const SizedBox(height: 20),
            const ElevatedButton1(),
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
                    builder: (context) => const Onboarding_Screen2(),
                  ));
            },
            child: const Text('Get Started'),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(const Color(0xFF677294))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Onboarding_Screen2(),
                  ));
            },
            child: Text("skip",
                style: GoogleFonts.rubik(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 0.12,
                  letterSpacing: -0.30,
                )),
          )
        ],
      ),
    );
  }
}

final ButtonStyle bluestyle = ElevatedButton.styleFrom(
  padding: (const EdgeInsets.fromLTRB(100, 20, 100, 20)),
  textStyle:
      GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400, height: 0),
  backgroundColor: const Color(0xff374366),
  foregroundColor: Colors.white,
);
