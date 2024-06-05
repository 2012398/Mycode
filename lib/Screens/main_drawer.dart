// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fyp/Screens/AddBaby.dart';
import 'package:fyp/Screens/allchats.dart';
import 'package:fyp/Screens/baby_profile.dart';
import 'package:fyp/Screens/educational_resources.dart';
import 'package:fyp/Screens/login_screen.dart';
import 'package:fyp/Screens/onboarding_screen1.dart';
import 'package:fyp/Screens/pediatrician_consultation.dart';
import 'package:fyp/Screens/privacy_policy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xff374366),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("images/Nabeel.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName!,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              user.email!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Baby_profile(),
                  ));
            },
            title: Text(
              "Baby Profile",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_sharp),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationalResources(),
                  ));
            },
            title: Text(
              "Educational Resources",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConsultationScreen(),
                  ));
            },
            title: Text(
              "Pediatrician consultation",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Privacypolicy(),
                  ));
            },
            title: Text(
              "Privacy & Policy",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            onTap: () {
              showBecomeDoctorDialog(context);
            },
            title: Text(
              "Switch to doctor?",
              style: GoogleFonts.rubik(),
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomLeft,
            child: ListTile(
              leading: const Icon(Icons.logout_rounded),
              onTap: () {
                logout(context);
              },
              title: Text(
                "Logout",
                style: GoogleFonts.rubik(),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void showBecomeDoctorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to become a doctor?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Implement action for Yes
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Implement action for No
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
