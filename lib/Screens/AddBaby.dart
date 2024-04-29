import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../db.dart' as db;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu_screen1.dart';

class AddBaby extends StatefulWidget {
  const AddBaby({super.key});

  @override
  State<AddBaby> createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
  TextEditingController name = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: const Text('Baby Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Baby\'s Name: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter baby\'s name';
                    }
                    // Define a regular expression pattern for full names
                    final RegExp nameRegex =
                        RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$');
                    if (!nameRegex.hasMatch(value)) {
                      return 'Please enter a valid full name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter full name',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Blood Group:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: bloodGroup,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter blood group';
                    }
                    final RegExp bloodGroupRegex = RegExp(r'^(A|B|AB|O)[+-]$');
                    if (!bloodGroupRegex.hasMatch(value)) {
                      return 'Please enter a valid blood group (e.g., A+, B-, AB+, O-)';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter blood group',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Age:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: age,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }

                    // Split the input into numeric value and unit
                    final parts = value.split(' ');
                    if (parts.length != 2) {
                      return 'Please enter age in the format "X month(s)" or "X year(s)"';
                    }

                    final numericValue = int.tryParse(parts[0]);
                    final unit = parts[1];

                    // Validate the numeric value
                    if (numericValue == null ||
                        numericValue < 1 ||
                        numericValue > 150) {
                      return 'Please enter a valid numeric value (1-150)';
                    }

                    // Validate the unit
                    if (unit != 'month' && unit != 'year') {
                      return 'Please enter either "month" or "year" as unit';
                    }

                    return null; // Valid age
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter age (e.g., 1 month or 5 years)',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Height(cm):',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: height,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter height';
                    }

                    // Define a regex pattern for validating height in cm
                    final RegExp cmRegex = RegExp(r'^[1-9]\d*$');

                    // Check if the input matches the regex pattern
                    if (!cmRegex.hasMatch(value)) {
                      return 'Please enter a valid height in cm';
                    }

                    return null; // Valid height
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter height in cm',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Weight(kgs):',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }

                    // Define a regex pattern to match positive numbers
                    final RegExp digitRegex = RegExp(r'^[1-9]\d*$');

                    // Check if the input matches the regex pattern
                    if (!digitRegex.hasMatch(value)) {
                      return 'Please enter a valid weight in kgs';
                    }

                    return null; // Valid weight
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter weight in kgs',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff374366),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Only perform action if form is valid
            addBaby(uid);
          }
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Future<void> addBaby(String userId) async {
    final String apiUrl = '${db.dblink}/babyprofile$userId';
    print("api url: $apiUrl");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'babyname': name.text.toString(),
        'Bloodgroup': bloodGroup.text.toString(),
        'Age': age.text.toString(),
        'Weight': weight.text.toString(),
        'Height': height.text.toString(),
        'uid': userId.toString(),
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // User created successfully
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' ${responseData['message']}'),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuScreen1(),
        ),
      );
    } else if (response.statusCode == 400) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' ${responseData['message']}'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${responseData['error']}')),
      );
    }
  }
}
