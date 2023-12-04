import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;
import 'dart:convert';

const String dblink = "http://192.168.100.81:3000";
// final String dblink = "http://192.168.0.102:3000";

Future<void> addToCart(String userId, final product) async {
  final String apiUrl = '${db.dblink}/add-to-cart$userId';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'itemName': product['ProductName'],
      'quantity': 1,
      'price': product['ProductPrice'],
      'category': product['ProductCategory']
    }),
  );

  if (response.statusCode == 201) {
    print('Item added to cart successfully');
    print('userid: $userId');
  } else {
    print(
        'Failed to add item to cart. Error: ${response.statusCode}\n${response.body}');
  }
}
