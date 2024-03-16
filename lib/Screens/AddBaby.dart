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
  TextEditingController Name = TextEditingController();
  TextEditingController Bloodgroup = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Height = TextEditingController();
  TextEditingController Weight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: const Text('Baby Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Baby\'s Name: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Blood Group:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Age:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Height:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Weight:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addbaby(uid);
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Future<void> addbaby(String userId) async {
    final String apiUrl = '${db.dblink}/babyprofile$userId';
    print("api url: $apiUrl");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'babyname': Name.text.toString(),
        'Bloodgroup': Bloodgroup.text.toString(),
        'Weight': Weight.text.toString(),
        'Height': Height.text.toString()
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // User created successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' ${responseData['message']}'),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuScreen1(),
          ));
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' ${responseData['message']}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${responseData['error']}')));
    }
  }
}
