import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db.dart' as db;
import 'dart:convert';
import 'package:http/http.dart' as http;

var responsefromapi;

// Define Doctor class
class Doctor {
  final String name;
  final String uid;
  final List<String> availableDays; // List of available days
  final List<String> availableTimes; // List of available times

  Doctor({
    required this.name,
    required this.uid,
    required this.availableDays,
    required this.availableTimes,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['displayName'] as String,
      uid: json['uid'] as String,
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableTimes: List<String>.from(json['availableTimes'] ?? []),
    );
  }
}

class updatedAppointments extends StatefulWidget {
  const updatedAppointments({Key? key}) : super(key: key);

  @override
  _updatedAppointmentsState createState() => _updatedAppointmentsState();
}

class _updatedAppointmentsState extends State<updatedAppointments> {
  Doctor? selectedDoctor;
  List<Doctor> doctors = [];

  // List<Doctor> doctors = [
  //   Doctor(
  //     name: "Dr. John Doe",
  //     uid: "1",
  //     availableDays: ["Monday", "Wednesday", "Friday"],
  //     availableTimes: ["10:00 AM", "11:00 AM", "2:00 PM"],
  //   ),
  //   Doctor(
  //     name: "Dr. Jane Smith",
  //     uid: "2",
  //     availableDays: ["Tuesday", "Thursday", "Saturday"],
  //     availableTimes: ["9:00 AM", "1:00 PM", "3:00 PM"],
  //   ),
  //   // Add more doctors as needed
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getinvo();
  }

  String? selectedDay;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pediatrician Consultation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Doctor:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Doctor>(
              value: selectedDoctor,
              onChanged: (Doctor? doctor) {
                setState(() {
                  selectedDoctor = doctor;
                  selectedDay = null;
                  selectedTime = null;
                });
              },
              items: doctors.map((Doctor doctor) {
                return DropdownMenuItem<Doctor>(
                  value: doctor,
                  child: Text(doctor.name),
                );
              }).toList(),
            ),
            if (selectedDoctor != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Select Day:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Display available days
              Row(
                children: selectedDoctor!.availableDays.map((day) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDay = day;
                        selectedTime = null;
                      });
                    },
                    child: Text(day),
                  );
                }).toList(),
              ),
              if (selectedDay != null) ...[
                const SizedBox(height: 20),
                const Text(
                  'Select Time:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Display available times
                Row(
                  children: selectedDoctor!.availableTimes.map((time) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                      child: Text(time),
                    );
                  }).toList(),
                ),
                if (selectedTime != null) ...[
                  ElevatedButton(
                    onPressed: () {
                      // Book appointment logic
                    },
                    child: const Text('Book Appointment'),
                  ),
                ],
              ],
            ],
          ],
        ),
      ),
    );
  }

  Future<void> Getinvo() async {
    var url = Uri.parse("${db.dblink}/get-doctors");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);
      print(response.body);
      setState(() {
        doctors = fetchedData.map((data) => Doctor.fromJson(data)).toList();
      });
    } else {
      print("Error22: ${response.statusCode}");
      print("Response22: ${response.body}");
      throw Exception("Failed to load data");
    }
  }

  Future<String> bookAppointment(String userId, String selectedDate,
      String selectedTime, String doctorsname) async {
    const String apiUrl = '${db.dblink}/bookAppointment';
    print("api url: $apiUrl");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'doctorname': doctorsname.toString(),
        'selectedDate': selectedDate.toString(),
        'selectedTime': selectedTime.toString(),
        'PatientName': userId.toString()
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print(responseData['message']);

    responsefromapi = responseData['message'];
    return responseData['message'];
  }
}
