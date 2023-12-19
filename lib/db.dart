// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;
import 'dart:convert';

// const String dblink = "http://192.168.100.81:3000";
final String dblink = "http://192.168.0.102:3000";

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
