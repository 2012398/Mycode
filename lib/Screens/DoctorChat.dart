import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:fyp/db.dart' as db;
import '../db.dart';
import 'ChatAPI.dart';

class Doctorchat extends StatefulWidget {
  final Map<String, dynamic> doctor;

  Doctorchat({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorchatState createState() => _DoctorchatState();
}

var PatientName;

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
    var patient = widget.doctor;
    setState(() {
      PatientName = patient;
    });
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 2),
        child: FloatingActionButton(
          onPressed: () => {fetchAppointments(), _showBottomDrawer(context)},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> data = [];

  Future<void> fetchAppointments() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(PatientName['displayName'].toString())));
      var url = Uri.parse(
          "${db.dblink}/get-baby/${PatientName['displayName'].toString()}");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      print(url.toString());
      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));
          print(response.body);
        });
      } else {
        print("Error22: ${response.statusCode}");
        print("Response22: ${response.body}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      // Handle error here, show a dialog or set an error state.
    }
  }

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Childs'),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // Ensure index is within bounds of data length
                  return ListTile(
                    title: Text(
                      data[index]['babyname'].toString(),
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem(
                            label: 'Age',
                            value: data[index]['Age'].toString(),
                            icon: Icons.cake,
                            color: Colors.blue,
                          ),
                          _buildDetailItem(
                            label: 'Blood Group',
                            value: data[index]['Bloodgroup'].toString(),
                            icon: Icons.bloodtype,
                            color: Colors.red,
                          ),
                          _buildDetailItem(
                            label: 'Height',
                            value: data[index]['Height'].toString(),
                            icon: Icons.height,
                            color: Colors.green,
                          ),
                          _buildDetailItem(
                            label: 'Weight',
                            value: data[index]['Weight'].toString(),
                            icon: Icons.fitness_center,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Do something
                      Navigator.pop(context); // Close the drawer
                    },
                  );
                },
              ),
              // Add more items as needed
            ],
          ),
        );
      },
    );
  }
}

Widget _buildDetailItem({
  required String label,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: color,
        ),
        const SizedBox(width: 10),
        Text(
          '$label: $value',
          style: GoogleFonts.rubik(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
