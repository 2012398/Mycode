import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db.dart' as db;
class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  var data = {};
  Future<void> Getinvo(String category) async {
    var url =
        Uri.parse("${db.dblink}/inventory?category=$category");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
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
    Getinvo("Medicine");
  }

  @override
  Widget build(BuildContext context) {
    var obj = data['Products'];

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: data['Products'].length,
            itemBuilder: ((context, index) {
              final counter = obj[index];
              return ListTile(
                title: Text(counter['ProductName']),
                subtitle: Text(index.toString()),
              );
            }),
          ),
        ),
      ),
    );
  }
}
