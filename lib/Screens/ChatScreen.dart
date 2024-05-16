// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Cart.dart';
import 'package:fyp/db.dart' as db;
import 'package:fyp/Screens/ChatAPI.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String doctor;
  final String doctorname;
  const ChatScreen({super.key, required this.doctor, required this.doctorname});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? galleryFile; 
final picker = ImagePicker(); 

  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> messages = [];
  @override
  void initState() {
    super.initState();
    // print(widget.doctor);
    // Fetch messages initially
    fetchMessages();
    // Fetch messages periodically
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    //   fetchMessages();
    // });
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
      final newMessages = await ChatAPI.getMessages('${widget.doctor}_$uid');
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
        title: Text('Chat by patient'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message['SenderId'].toString() == widget.doctor) {
            return ListTile(
              subtitle: Text(message['content']),
              title: Text(widget.doctorname),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
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
                        sendMessage( newMessage.text);
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
            Padding(
              child: GestureDetector(
                child: const Icon(
                  CupertinoIcons.camera,
                  color: Colors.green,
                ),
                onTap:() {
                  _showPicker(context: context); 
                }, 
              ),
              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _uploadVideo() async {
  //   var request = http.MultipartRequest('POST', Uri.parse('YOUR_API_ENDPOINT'));
  //   request.files.add(await http.MultipartFile.fromPath('video', _video!.path));

  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     print('Video uploaded successfully');
  //   } else {
  //     print('Failed to upload video: ${response.reasonPhrase}');
  //   }
  // }

  

  Future<void> sendMessage(var message) async {
    String url =
        '${db.dblink}/send-message'; // Replace this with your API endpoint
    var body = {
      'DoctorId': widget.doctor.toString(),
      'PatientId': uid.toString(),
      'content': message.toString(),
      'SenderId': uid.toString(),
    };
    // print(body);

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Message sent successfully');
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
    void _showPicker({ 
	required BuildContext context, 
}) { 
	showModalBottomSheet( 
	context: context, 
	builder: (BuildContext context) { 
		return SafeArea( 
		child: Wrap( 
			children: <Widget>[ 
			ListTile( 
				leading: const Icon(Icons.photo_library), 
				title: const Text('Gallery'), 
				onTap: () { 
				getVideo(ImageSource.gallery); 
				Navigator.of(context).pop(); 
				}, 
			), 
			ListTile( 
				leading: const Icon(Icons.photo_camera), 
				title: const Text('Camera'), 
				onTap: () { 
				getVideo(ImageSource.camera); 
				Navigator.of(context).pop(); 
				}, 
			), 
			], 
		), 
		); 
	}, 
	); 
} Future getVideo( 
	ImageSource img, 
) async { 
	final pickedFile = await picker.pickVideo( 
		source: img, 
		preferredCameraDevice: CameraDevice.rear, 
		maxDuration: const Duration(seconds: 15)); 
	XFile? xfilePick = pickedFile; 
	setState( 
	() { 
		if (xfilePick != null) { 
		galleryFile = File(pickedFile!.path); 
    //uploading video directly
    uploadVideo(galleryFile!);
		} else { 
		ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
			const SnackBar(content: Text('Nothing is selected'))); 
		} 
	}, 
	); 
}  Future<void> uploadVideo(File videoFile) async {
    // API endpoint URL
    var apiUrl = Uri.parse('${db.dblink}/uploadVideo');

    try {
      // Send a POST request to the API endpoint with the video file
      var request = http.MultipartRequest('POST', apiUrl)
        ..files.add(await http.MultipartFile.fromPath('video', videoFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Video uploaded successfully
        var responseData = await response.stream.bytesToString();
        var videoUrl = jsonDecode(responseData)['videoUrl'];
        sendMessage(videoUrl);
        print('Video uploaded successfully. URL: $videoUrl');
      } else {
        // Handle error response
        print('Error uploading video. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error uploading video: $e');
    }
  }
}
