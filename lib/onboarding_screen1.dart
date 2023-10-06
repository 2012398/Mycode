import 'package:flutter/material.dart';
import 'package:fyp/colors.dart';
import 'package:fyp/onboarding_screen2.dart';

class Onboarding_Screen1 extends StatelessWidget {
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
                image: AssetImage('assets/images/On-board-pic1.png'),
                width: 400,
                height: 400),

            // const SizedBox(
            //   height: 100,
            // ),
            Text(
              'Find Trusted Doctors',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0.5,
                  color: Colors.black.withOpacity(0.75999)),
            ),
            SizedBox(height: 10),
            // Padding(padding: EdgeInsets.only(top: 5)),

            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: -0.30,
                  color: Colors.black.withOpacity(0.75999)),
            ),
            SizedBox(height: 70),
            ElevatedButtonExample(),
          ],
        ),
      ),
    );
  }
}

class ElevatedButtonExample extends StatefulWidget {
  const ElevatedButtonExample({super.key});

  @override
  State<ElevatedButtonExample> createState() => _ElevatedButtonExampleState();
}

class _ElevatedButtonExampleState extends State<ElevatedButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: bluestyle,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen2(),
                  ));
            },
            child: const Text('Get Started'),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Color(0xFF677294))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen2(),
                  ));
            },
            child: const Text(
              "skip",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 0.12,
                  letterSpacing: -0.30),
            ),
          )
        ],
      ),
    );
  }
}

final ButtonStyle bluestyle = ElevatedButton.styleFrom(
  padding: (EdgeInsets.fromLTRB(100, 20, 110, 20)),
  textStyle: const TextStyle(
    fontFamily: 'Rubik',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 0,
  ),
  backgroundColor: Color(0xff374366),
  foregroundColor: Colors.white,
);
