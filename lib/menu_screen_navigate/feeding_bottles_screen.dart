import 'package:flutter/material.dart';
import '../db.dart' as db;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Feeding_bottle extends StatefulWidget {
  const Feeding_bottle({super.key});

  @override
  State<Feeding_bottle> createState() => _Feeding_bottleState();
}

class _Feeding_bottleState extends State<Feeding_bottle> {
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
    Getinvo("Feeding bottle");
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
