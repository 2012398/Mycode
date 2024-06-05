import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../db.dart';
import 'ChatAPI.dart';

class Doctorchat extends StatefulWidget {
  final Map<String, dynamic> doctor;

  Doctorchat({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorchatState createState() => _DoctorchatState();
}

class _DoctorchatState extends State<Doctorchat> {
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> messages = [];
  final TextEditingController newMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  bool _isURL(String text) {
    return Uri.tryParse(text)?.hasScheme ?? false;
  }

  Future<void> fetchMessages() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final newMessages =
          await ChatAPI.getMessages('${user.uid}_${widget.doctor['uid']}');
      if (mounted) {
        setState(() {
          messages = newMessages;
          isLoading = false; // Set isLoading to false after fetching messages
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      }
    } catch (e) {
      print('Error fetching messages: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _initializeVideoPlayer(String url) async {
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> sendMessage() async {
    String url =
        '${dblink}/send-message'; // Replace this with your API endpoint
    var body = {
      'DoctorId': user.uid.toString(),
      'PatientId': widget.doctor['uid'].toString(),
      'content': newMessage.text,
      'SenderId': user.uid.toString(),
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Message sent successfully');
        fetchMessages();
        newMessage.clear();
      } else {
        print('Failed to send message. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during message sending: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff374366),
        title: Text('Chat with ${widget.doctor['displayName']}'),
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
                          message['SenderId'] == user.uid
                              ? user.displayName!
                              : widget.doctor['displayName'],
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
                                child: AspectRatio(
                                  aspectRatio: 16 / 10,
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
                                              return const Center(
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
                      sendMessage();
                    }
                  },
                  child: const Icon(
                    size: 40,
                    CupertinoIcons.arrow_right_circle_fill,
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
