import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/db.dart' as db;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('My Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xff374366),
            //   ),
            //   onPressed: () {},
            //   child: const Padding(
            //     padding: EdgeInsets.all(20),
            //     child: Text(
            //       'View Reports',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Patients',
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
                    subtitle: Text('${data[index]['selectedTime']}'),
                    title: Text('${data[index]['doctorname']}'),
                    // subtitle: Text('Age: ${6 + index}'),
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

  List<Map<String, dynamic>> data = [];
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> fetchAppointments() async {
    try {
      var url =
          Uri.parse("${db.dblink}/get-appointmentsbyuser/${user.displayName}");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});

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
    } catch (e) {
      print("Error: $e");
      // Handle error here, show a dialog or set an error state.
    }
  }
}
