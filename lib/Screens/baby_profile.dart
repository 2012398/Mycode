import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddBaby.dart';
import 'package:fyp/db.dart' as db;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Baby_Profile extends StatefulWidget {
  const Baby_Profile({super.key});

  @override
  State<Baby_Profile> createState() => _BabyProfileState();
}

class _BabyProfileState extends State<Baby_Profile> {
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
      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        print("Error22: ${response.statusCode}");
        print("Response22: ${response.body}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Text(
                        data[index]['babyname'].toString(),
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Container(
                        height:
                            100, // Set a fixed height for the scrollable area
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailItem(
                                label: 'Age',
                                value: data[index]['Age'].toString(),
                                icon: Icons.cake,
                                color: Colors.blue,
                              ),
                              _buildDetailItem(
                                label: 'Blood Group',
                                value: data[index]['Bloodgroup'].toString(),
                                icon: Icons.bloodtype,
                                color: Colors.red,
                              ),
                              _buildDetailItem(
                                label: 'Height',
                                value: data[index]['Height'].toString(),
                                icon: Icons.height,
                                color: Colors.green,
                              ),
                              _buildDetailItem(
                                label: 'Weight',
                                value: data[index]['Weight'].toString(),
                                icon: Icons.fitness_center,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(width: 10),
          Text(
            '$label: $value',
            style: GoogleFonts.rubik(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
