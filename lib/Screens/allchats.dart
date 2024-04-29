import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/DoctorChat.dart';
import 'package:fyp/db.dart' as db;
import 'package:http/http.dart' as http;

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  void initState() {
    super.initState();
    fetchChatRoomIds();
  }

  final user = FirebaseAuth.instance.currentUser!;
  List<String> chatRoomIds = [];
  List<String> chatRoomPatient = [];
  List<Map<String, dynamic>> userDetails = [];
  Future<void> fetchChatRoomIds() async {
    final userId = user.uid; // Replace with the actual userId
    final apiUrl =
        '${db.dblink}/chatRoomIds/$userId'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          chatRoomIds =
              data.map((item) => item['chatRoomId'] as String).toList();
          chatRoomPatient = data.map((item) => item['user'] as String).toList();
          fetchUserDetails();
        });
      } else {
        throw Exception('Failed to fetch chat room IDs');
      }
    } catch (error) {
      print('Error fetching chat room IDs: $error');
      // Handle error
    }
  }

  Future<void> fetchUserDetails() async {
    final apiUrl = '${db.dblink}/userDetails';
    final Map<String, dynamic> requestBody = {'userIds': chatRoomPatient};

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          userDetails = List<Map<String, dynamic>>.from(data);
          // print(userDetails[0]['uid']);
        });
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (error) {
      print('Error fetching user details: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Chats'),
      ),
      body: ListView.builder(
        itemCount: userDetails.length,
        itemBuilder: (context, index) {
          // final chatRoomId = chatRoomIds[index];
          final PatientName = userDetails[index]['displayName'];
          return ListTile(
            title: Text(PatientName),
            // You can navigate to the chat room using this chat room ID
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Doctorchat(doctor: userDetails[index]),
                ),
              );
              // Navigate to the chat room screen with the selected chat room ID
            },
          );
        },
      ),
    );
  }
}
