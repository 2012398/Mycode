import 'package:flutter/material.dart';
import 'package:fyp/Screens/login_screen.dart';
import 'package:fyp/Screens/onboarding_screen1.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("images/Nabeel.png"),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nabeel hussain",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "0332-3287112",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // decoration: BoxDecoration(shape: BoxShape.circle),
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
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "My Doctors",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.medical_information),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "Medical Records",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.baby_changing_station_outlined),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "Add Baby",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_sharp),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen1(),
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
                    builder: (context) => Onboarding_Screen1(),
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
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "Privacy & Policy",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help_rounded),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "Help Center",
              style: GoogleFonts.rubik(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding_Screen1(),
                  ));
            },
            title: Text(
              "Settings",
              style: GoogleFonts.rubik(),
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomLeft,
            child: ListTile(
              leading: const Icon(Icons.logout_rounded),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
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
}
