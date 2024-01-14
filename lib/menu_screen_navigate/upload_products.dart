// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db.dart' as db;

class Upload_product extends StatefulWidget {
  const Upload_product({Key? key});

  @override
  State<Upload_product> createState() => _Upload_productState();
}

class _Upload_productState extends State<Upload_product> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff374366),
        title: Text('Upload Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productName,
              decoration: InputDecoration(
                hintText: 'Enter product name',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Price',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter product price',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Quantity',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter product quantity',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Product Category',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productCategory,
              decoration: InputDecoration(
                hintText: 'Enter product category',
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  uploadInvoice();
                },
                child: Text('Upload Item'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff374366)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> uploadInvoice() async {
    final String apiUrl = "${db.dblink}/uploadinvo";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ProductName': productName.text.toString(),
          'ProductPrice': int.tryParse(productPrice.text.toString()) ?? 0,
          'ProductQuantity': int.tryParse(productQuantity.text.toString()) ?? 0,
          'ProductCategory': productCategory.text.toString(),
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
