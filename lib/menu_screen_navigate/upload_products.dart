// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db.dart' as db;

class Upload_product extends StatefulWidget {
  const Upload_product({super.key});

  @override
  State<Upload_product> createState() => _Upload_productState();
}

class _Upload_productState extends State<Upload_product> {
  TextEditingController Productname = TextEditingController();
  TextEditingController ProductPrice = TextEditingController();
  TextEditingController ProductQuantity = TextEditingController();
  TextEditingController ProductCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text("Upload Products"),
          Text("Product Name"),
          TextField(
            controller: Productname,
          ),
          Text("Product Price"),
          TextField(
            controller: ProductPrice,
          ),
          Text("Product Quantity"),
          TextField(
            controller: ProductQuantity,
          ),
          Text("Product Category"),
          TextField(
            controller: ProductCategory,
          ),
          ElevatedButton(
            onPressed: () {
              UploadInvo();
            },
            child: Text('Upload Item'),
          )
        ],
      ),
    );
  }

  Future<void> UploadInvo() async {
    final String apiUrl = "${db.dblink}/uploadinvo";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ProductName': Productname.text.toString(),
          'ProductPrice': int.tryParse(ProductPrice.text.toString()) ?? 0,
          'ProductQuantity': int.tryParse(ProductQuantity.text.toString()) ?? 0,
          'ProductCategory': ProductCategory.text.toString(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item Added')));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User Already Exists.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${response.statusCode} / ${response.body}')));
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
