import 'package:flutter/material.dart';
import 'package:fyp/colors.dart';
import 'package:fyp/onboarding_screen1.dart';

class Onboarding_Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        color: Onboardcolor2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
                image: AssetImage('assets/images/On-board-pic2.png'),
                width: 300,
                height: 130),
            // const SizedBox(
            //   height: 1,
            // ),
            Text(
              'In app consultation',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: 0.5,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            // Padding(padding: EdgeInsets.only(top: 5)),

            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: -0.30,
                  color: Colors.white),
            ),
            SizedBox(height: 70),

            ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Onboarding_Screen1(),
                      ));
                },
                child: Text('Skip'))
          ],
        ),
      ),
    );
  }
}
