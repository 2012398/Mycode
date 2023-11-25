import 'package:flutter/material.dart';
import '../db.dart' as db;
import 'dart:convert';
import 'package:http/http.dart' as http;

class Skin_care extends StatefulWidget {
  const Skin_care({super.key});

  @override
  State<Skin_care> createState() => _Skin_careState();
}

class _Skin_careState extends State<Skin_care> {
  var data = {};
  Future<void> Getinvo(String category) async {
    var url = Uri.parse("${db.dblink}/inventory?category=$category");
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
    Getinvo("Skin Care");
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
