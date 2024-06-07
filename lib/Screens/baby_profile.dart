import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddBaby.dart';
import 'package:fyp/db.dart' as db;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Baby_profile extends StatefulWidget {
  const Baby_profile({super.key});

  @override
  State<Baby_profile> createState() => _Baby_profileState();
}

class _Baby_profileState extends State<Baby_profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  List<Map<String, dynamic>> data = [];
  Future<void> fetchAppointments() async {
    try {
      var url = Uri.parse("${db.dblink}/get-baby/${user.displayName}");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      print(url.toString());
      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Details'),
        backgroundColor: const Color(0xff374366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                // Ensure index is within bounds of data length
                return ListTile(
                  title: Text(data[index]['babyname'].toString()),
                  subtitle: Text(data[index]['Age'].toString()),
                  onTap: () {
                    // Do something
                    Navigator.pop(context); // Close the drawer
                  },
                );
              },
            ),
            // _buildDetailItem(
            //   label: 'Baby Name',
            //   value: 'John Doe',
            //   icon: Icons.child_care,
            //   color: Colors.blue,
            // ),
            // _buildDetailItem(
            //   label: 'Blood Group',
            //   value: 'O+',
            //   icon: Icons.opacity,
            //   color: Colors.green,
            // ),
            // _buildDetailItem(
            //   label: 'Age',
            //   value: '6 months',
            //   icon: Icons.calendar_today,
            //   color: Colors.orange,
            // ),
            // _buildDetailItem(
            //   label: 'Height',
            //   value: '60 cm',
            //   icon: Icons.height,
            //   color: Colors.purple,
            // ),
            // _buildDetailItem(
            //   label: 'Weight',
            //   value: '7 kg',
            //   icon: Icons.fitness_center,
            //   color: Colors.red,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBaby()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            textStyle:
                GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.w400),
            backgroundColor: const Color(0xff374366),
          ),
          child: const Text('Add Baby'),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
