import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;

class ChatAPI {
  static const String baseUrl = db.dblink; // Replace with your API base URL

  static Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    final url = Uri.parse('$baseUrl/send-message');
    final response = await http.post(
      url,
      body: jsonEncode({
        'senderId': senderId,
        'receiverId': receiverId,
        'content': content,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else {
      print(response.statusCode);
      throw Exception('Failed to send message');
    }
  }

  static Future<List<dynamic>> getMessages(String chatRoomId) async {
    final url = Uri.parse('$baseUrl/get-messages/$chatRoomId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      print(response.statusCode);

      throw Exception('Failed to get messages');
    }
  }
}
