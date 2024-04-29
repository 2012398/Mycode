// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;
import 'dart:convert';

<<<<<<< HEAD
const String dblink = "http://192.168.0.194:3000";
// const String dblink = "http://192.168.0.102:3000";
=======
// // const String dblink = "http://192.168.0.194:3000";
const String dblink = "http://192.168.0.102:3000";
>>>>>>> 5460dc38f3113e14594796ded5ac5f62c0042064

Future<void> addToCart(String userId, final product) async {
  final String apiUrl = '${db.dblink}/add-to-cart$userId';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'itemName': product['ProductName'],
      'price': product['ProductPrice'],
      'category': product['ProductCategory']
    }),
  );
}

Future<bool> ClearCart(String userId, BuildContext context) async {
  final String apiUrl = '${db.dblink}/CartClear:$userId';

  final response = await http.delete(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // print('Item added to cart successfully');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cart Cleared'),
      ),
    );
    print('userid: $userId');
    return true;
  } else {
    print(
        'Failed to add item to cart. Error: ${response.statusCode}\n${response.body}');
    return false;
  }
}
