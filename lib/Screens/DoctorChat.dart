// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../db.dart' as db;
import 'Cart.dart';
import 'ChatAPI.dart';

class DoctorChat extends StatefulWidget {
  final String doctor;
  final String doctorname;

  const DoctorChat({Key? key, required this.doctor, required this.doctorname});

  @override
  _DoctorChatState createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> messages = [];
  final TextEditingController newMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final picker = ImagePicker();
  // Map to hold FlickManager for each video message
  Map<int, FlickManager> _flickManagers = {};

  @override
  void initState() {
    super.initState();
    fetchMessages();

    Timer.periodic(const Duration(seconds: 12), (timer) {
      fetchMessages();
    });
  }

  @override
  void dispose() {
    // Dispose all FlickManagers
    _flickManagers.forEach((key, flickManager) {
      flickManager.dispose();
    });
    newMessage.dispose();
    super.dispose();
  }

  bool _isURL(String text) {
    return Uri.tryParse(text)?.hasScheme ?? false;
  }

  Future<void> fetchMessages() async {
    try {
      final newMessages =
          await ChatAPI.getMessages('${user.uid}_${widget.doctor}');
      setState(() {
        messages = newMessages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<void> _initializeVideoPlayer(int index, String url) async {
    if (!_flickManagers.containsKey(index)) {
      FlickManager flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(url),
      );

      setState(() {
        _flickManagers[index] = flickManager;
      });
    }
  }

  Future<void> sendMessage(var message) async {
    String url =
        '${db.dblink}/send-message'; // Replace this with your API endpoint
    var body = {
      'DoctorId': user.uid.toString(),
      'PatientId': widget.doctor.toString(),
      'content': message.toString(),
      'SenderId': user.uid.toString(),
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

  Future<void> getVideo(
    ImageSource img,
    CameraDevice cameraDevice,
  ) async {
    final pickedFile = await picker.pickVideo(
      source: img,
      preferredCameraDevice: cameraDevice,
      maxDuration: const Duration(seconds: 15),
    );
    XFile? xfilePick = pickedFile;
    setState(() {
      if (xfilePick != null) {
        File file = File(pickedFile!.path);
        uploadVideo(file);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  Future<void> uploadVideo(File videoFile) async {
    var apiUrl = Uri.parse('${db.dblink}/uploadVideo');

    try {
      var request = http.MultipartRequest('POST', apiUrl)
        ..files.add(await http.MultipartFile.fromPath('video', videoFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var videoUrl = jsonDecode(responseData)['videoUrl'];
        sendMessage(videoUrl);
        print('Video uploaded successfully. URL: $videoUrl');
      } else {
        print('Error uploading video. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
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
                bool isSentByUser = message['SenderId'] == user.uid;
                return Align(
                  alignment: isSentByUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSentByUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSentByUser ? 'You' : widget.doctorname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        _isURL(message['content'])
                            ? InkWell(
                                onTap: () async {
                                  if (await canLaunch(message['content'])) {
                                    await launch(message['content']);
                                  }
                                },
                                child: SizedBox(
                                  width: 100, // specify the width
                                  height: 200, // specify the height
                                  child: FutureBuilder(
                                    future: _initializeVideoPlayer(
                                        index, message['content']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return FlickVideoPlayer(
                                          flickManager: _flickManagers[index]!,
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            : Text(
                                message['content'],
                                style: const TextStyle(
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
                const SizedBox(width: 8),
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
                GestureDetector(
                  onTap: () async {
                    await fetchAppointments();
                    _showBottomDrawer(context);
                  },
                  child: const Icon(
                    size: 40,
                    CupertinoIcons.add_circled_solid,
                    color: Color(0xff374366),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Camera'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: const Text('Front Camera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getVideo(
                                        ImageSource.camera, CameraDevice.front);
                                  },
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  child: const Text('Rear Camera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getVideo(
                                        ImageSource.camera, CameraDevice.rear);
                                  },
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  child: const Text('Select from Device'),
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

  List<Map<String, dynamic>> data = [];
  Future<void> fetchAppointments() async {
    try {
      var url = Uri.parse("${db.dblink}/get-baby/${user.displayName}");
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        data = List<Map<String, dynamic>>.from(decodedData);
      } else {
        print("Failed to fetch appointments: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching appointments: $e");
    }
  }

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final item = data[index];
                return ListTile(
                  title: Text(item["name"]),
                  subtitle: Text('Appointment Date: ${item["DOB"]}'),
                  onTap: () {
                    sendMessage(item["name"]);
                    Navigator.pop(context); // Close the drawer after selection
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
