import 'package:flutter/material.dart';
import 'package:fyp/Screens/chatscreen.dart';
import 'package:fyp/Screens/checkout.dart';
import 'package:intl/intl.dart';
import '../db.dart' as db;
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: prefer_typing_uninitialized_variables
var responsefromapi;

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConsultationScreenState createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String selectedTime = 'Select Time';
  DateTime selectedDate = DateTime.now();

  // Sample list of doctors
  List<Doctor> doctors = [];
  var data = {};

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getinvo();
  }

  @override
  Widget build(BuildContext context) {
    // List doctorUid = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
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
            const SizedBox(height: 10),
            // Display list of doctors
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: doctors[index],
                    onDateAndTimeSelected: (selectedTime) {
                      // TODO: Handle date and time selection for the specific doctor
                      // You can use selectedDate and selectedTime here
                    },
                    onDateSelected: (selectedDate) {
                      setState(() {
                        this.selectedDate = selectedDate;
                      });
                    },
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
      'PatientName': user.displayName.toString()
    }),
  );
  final Map<String, dynamic> responseData = jsonDecode(response.body);
  print(responseData['message']);

  responsefromapi = responseData['message'];
  return responseData['message'];
}

class Doctor {
  final String name;
  final String uid;

  // final double rating;
  // final int reviews;

  Doctor({
    required this.name,
    required this.uid,
    // required this.rating,
    // required this.reviews,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['displayName'] as String,
      uid: json['uid'] as String,
      // rating: json['rating'] as double,
      // reviews: json['reviews'] as int,
    );
  }
}

class DoctorCard extends StatefulWidget {
  final Doctor doctor;

  // final Doctor uid;
  final Function(DateTime selectedTime) onDateAndTimeSelected;
  final Function(DateTime selectedDate) onDateSelected;

  const DoctorCard({
    super.key,
    required this.doctor,
    // required this.uid,
    required this.onDateAndTimeSelected,
    required this.onDateSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  String selectedTime = 'Select Time';
  DateTime? selectedDate;

  Future<void> _showTimePicker() async {
    TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null) {
      setState(() {
        selectedTime = selected.format(context);
      });

      if (selectedDate != null) {
        widget.onDateAndTimeSelected(DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selected.hour,
          selected.minute,
        ));
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff374366),
              ),
            ),
            child: child ?? Container(),
          );
        });

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doctor.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text('Experience: ${widget.doctor.experience}'),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                // Text(
                // '${widget.doctor.rating} (${widget.doctor.reviews} reviews)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff374366)),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : 'Select Date',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff374366)),
                    onPressed: () {
                      _showTimePicker();
                    },
                    child: Text(selectedTime),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) => ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () async {
                  if (selectedDate != null && selectedTime != 'Select Time') {
                    String response = await bookAppointment(
                        uid,
                        selectedDate!.toString(),
                        selectedTime.toString(),
                        widget.doctor.name);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select both date and time.'),
                      ),
                    );
                  }
                },
                child: const Text('Book Appointment'),
              ),
            ),
            Builder(
              builder: (context) => ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          doctor: widget.doctor.uid,
                          doctorname: widget.doctor.name),
                    ),
                  );
                },
                child: const Text('Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
