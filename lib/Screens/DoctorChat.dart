// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Cart.dart';
import 'package:fyp/db.dart' as db;
import 'package:fyp/Screens/ChatAPI.dart';
import 'package:http/http.dart' as http;

class Doctorchat extends StatefulWidget {
  var doctor;

  Doctorchat({super.key, required this.doctor});

  @override
  _DoctorchatState createState() => _DoctorchatState();
}

class _DoctorchatState extends State<Doctorchat> {
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> messages = [];
  @override
  void initState() {
    super.initState();
    print(widget.doctor);
    // print('${uid}_${widget.doctor}');
    // Fetch messages initially
    fetchMessages();
    // Fetch messages periodically
    Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchMessages();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    newMessage.dispose();
    super.dispose();
  }

  TextEditingController newMessage = TextEditingController();

  Future<void> fetchMessages() async {
    try {
      // print('${uid}_${widget.doctor}');
      final newMessages =
          await ChatAPI.getMessages('${uid}_${widget.doctor['uid']}');
      setState(() {
        messages = newMessages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message['SenderId'].toString() == widget.doctor['uid']) {
            return ListTile(
              subtitle: Text(message['content']),
              title: Text(widget.doctor['displayName']),
            );
          } else {
            return ListTile(
              subtitle: Text(message['content']),
              title: Text(user.displayName!),
            );
          }
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: TextField(
          controller: newMessage,
          onChanged: (value) {
            newMessage.text = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.all(10),
            hintText: "Type a message",
            suffixIcon: GestureDetector(
              onTap: () {
                if (newMessage.text.isNotEmpty) {
                  sendMessage();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('data')));
                }
              },
              child: const Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: Colors.green,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    String url =
        '${db.dblink}/send-message'; // Replace this with your API endpoint
    var body = {
      'DoctorId': uid.toString(),
      'PatientId': widget.doctor['uid'].toString(),
      'content': newMessage.text,
      'SenderId': uid.toString(),
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Message sent successfully2');
        // Handle success response here
      } else {
        print('Failed to send message. Error: ${response.statusCode}');
        // Handle error response here
      }
    } catch (e) {
      print('Exception during message sending: $e');
      // Handle exception here
    }
  }
}
