import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../db.dart'; // Make sure to replace this with your actual import paths
import 'Cart.dart'; // Make sure to replace this with your actual import paths
import 'ChatAPI.dart'; // Make sure to replace this with your actual import paths

class ChatScreen extends StatefulWidget {
  final String doctor;
  final String doctorname;

  const ChatScreen({Key? key, required this.doctor, required this.doctorname});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> messages = [];
  final TextEditingController newMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  VideoPlayerController? _videoPlayerController;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchMessages();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchMessages();
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    newMessage.dispose();
    super.dispose();
  }

  bool _isURL(String text) {
    return Uri.tryParse(text)?.hasScheme ?? false;
  }

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

  Future<void> _initializeVideoPlayer(String url) async {
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> sendMessage(var message) async {
    String url =
        '${dblink}/send-message'; // Replace this with your API endpoint
    var body = {
      'DoctorId': widget.doctor.toString(),
      'PatientId': uid.toString(),
      'content': message.toString(),
      'SenderId': uid.toString(),
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during message sending: $e');
    }
  }

  // Function to select the camera and capture a video
  Future<void> getVideo(
    ImageSource img,
    CameraDevice cameraDevice, // New parameter
  ) async {
    final pickedFile = await picker.pickVideo(
      source: img,
      preferredCameraDevice: cameraDevice, // Use the specified camera device
      maxDuration: const Duration(seconds: 15),
    );
    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        File file = File(pickedFile!.path);
        // Uploading video directly
        uploadVideo(file);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  // Function to upload the video file
  Future<void> uploadVideo(File videoFile) async {
    // API endpoint URL
    var apiUrl = Uri.parse('${dblink}/uploadVideo');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: Text('Chat with ${widget.doctorname}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSentByUser = message['SenderId'] == uid;
                return Align(
                  alignment: isSentByUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSentByUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSentByUser ? 'You' : widget.doctorname,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        _isURL(message['content'])
                            ? InkWell(
                                onTap: () async {
                                  if (await canLaunch(message['content'])) {
                                    await launch(message['content']);
                                  }
                                },
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: _videoPlayerController != null
                                      ? VideoPlayer(_videoPlayerController!)
                                      : FutureBuilder(
                                          future: _initializeVideoPlayer(
                                              message['content']),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return VideoPlayer(
                                                  _videoPlayerController!);
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                ),
                              )
                            : Text(
                                message['content'],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newMessage,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (newMessage.text.isNotEmpty) {
                      sendMessage(newMessage.text);
                      newMessage.clear();
                    }
                  },
                  child: const Icon(
                    size: 40,
                    CupertinoIcons.arrow_right_circle_fill,
                    color: Color(0xff374366),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    // Display dialog to choose camera
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Camera'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text('Front Camera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getVideo(
                                        ImageSource.camera, CameraDevice.front);
                                  },
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  child: Text('Rear Camera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getVideo(
                                        ImageSource.camera, CameraDevice.rear);
                                  },
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  child: Text('Select from Device'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getVideo(
                                        ImageSource.gallery, CameraDevice.rear);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    size: 40,
                    CupertinoIcons.camera,
                    color: Color(0xff374366),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
