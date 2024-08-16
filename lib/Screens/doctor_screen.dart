// ignore_for_file: unused_import, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/allchats.dart';
import 'package:fyp/Screens/chatscreen.dart';
import 'package:fyp/Screens/ShowAppointments.dart';
import 'package:fyp/db.dart' as db;
import 'package:http/http.dart' as http;
import 'package:fyp/Screens/login_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  List<Map<String, dynamic>> data = [];

  Future<void> fetchAppointments() async {
    try {
      if (user != null && user!.displayName != null) {
        var url = Uri.parse("${db.dblink}/get-appointments/${user!.displayName}");
        final response = await http.get(url, headers: {"Content-Type": "application/json"});

        if (response.statusCode == 200) {
          setState(() {
            data = List<Map<String, dynamic>>.from(
              json.decode(response.body),
            );
            // print(response.body);
          });
        } else {
          print("Error22: ${response.statusCode}");
          print("Response22: ${response.body}");
          throw Exception("Failed to load data");
        }
      }
    } catch (e) {
      print("Error: $e");
      // Handle error here, show a dialog or set an error state.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Doctor Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff374366),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: user?.photoURL != null
                        ? ClipOval(
                      child: Image.network(
                        user!.photoURL!,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    )
                        : Icon(Icons.person, size: 60, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.displayName ?? 'Doctor Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowAppointments(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('All Chats'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllChats(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Patients'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Appointments Booked By The Patients',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Row(
                      children: [
                        Text('${data[index]['selectedTime']}',),
                        SizedBox(width: 10),
                        Text('${data[index]['selectedDate']}',),
                      ],
                    ),
                    title: Text('${data[index]['PatientName']}'),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
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
}
