import 'package:flutter/material.dart';
import 'package:fyp/colors.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Onboarding_Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            enableLoop: false,
            waveType: WaveType.liquidReveal,
            enableSideReveal: false,
            slideIconWidget: Icon(
              Icons.arrow_back_ios_rounded,
              // Icons.arrow_back_ios,
              size: 15,
            ),
            positionSlideIcon: 0.5,
            pages: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: double.infinity,
                color: Onboardcolor1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                        image: AssetImage('assets/images/On-board-pic1.png'),
                        width: 200,
                        height: 200),

                    // const SizedBox(
                    //   height: 100,
                    // ),
                    Text(
                      'Find Trusted Doctors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          letterSpacing: -0.30,
                          color: Colors.black.withOpacity(0.75999)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),

                    Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: -0.30,
                          color: Colors.black.withOpacity(0.75999)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: double.infinity,
                color: Onboardcolor2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                      image: AssetImage('assets/images/On-board-pic2.png'),
                      width: 215,
                      height: 164,
                    ),
                    // const SizedBox(
                    //   height: 100,
                    // ),

                    Text(
                      'Find Trusted Doctors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          letterSpacing: -0.30,
                          color: Colors.black.withOpacity(0.75999)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),

                    Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          letterSpacing: -0.30,
                          color: Colors.black.withOpacity(0.75999)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 100,
                      ),
                    ),
                  ],
                ),
              ),
              Container(color: Colors.amberAccent)
            ],
          )
        ],
      ),
    );
  }
}
