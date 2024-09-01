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
    super.initState();
    fetchAppointments();
  }

  List<Map<String, dynamic>> data = [];
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> fetchAppointments() async {
    try {
      var url = Uri.parse("${db.dblink}/get-appointmentsbyuser/${user.displayName}");
      final response = await http.get(url, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        print("Error: ${response.statusCode}");
        throw Exception("Failed to load appointments");
      }
    } catch (e) {
      print("Error: $e");
    }
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
            const SizedBox(height: 20),
            const Text(
              'Appointments Booked:',
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
                  final appointment = data[index];
                  final doctorName = appointment['doctorname'];
                  final timeSlot = appointment['selectedTime'];
                  final status = appointment['Status'] ?? 'Pending';  // Default to Pending if status is not available

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dr. $doctorName',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        // Status display logic on the right side
                        Text(
                          status,
                          style: TextStyle(
                            color: status == 'Approved'
                                ? Colors.green
                                : (status == 'Rejected' ? Colors.red : Colors.blue),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text('Time: $timeSlot'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
