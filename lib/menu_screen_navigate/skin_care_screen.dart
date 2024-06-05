// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../db.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Skin_care extends StatefulWidget {
  const Skin_care({Key? key}) : super(key: key);

  @override
  State<Skin_care> createState() => _Skin_careState();
}

class _Skin_careState extends State<Skin_care> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  var data = {};

  Future<void> Getinvo(String category) async {
    var url = Uri.parse("${db.dblink}/inventory?category=$category");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      print("Error22: ${response.statusCode}");
      print("Response22: ${response.body}");
      throw Exception("Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();
    Getinvo("Skin Care");
  }

  @override
  Widget build(BuildContext context) {
    var obj = data['Products'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin care'),
        backgroundColor: const Color(0xff374366),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: (obj == null)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: obj.length,
                  itemBuilder: (context, index) {
                    final product = obj[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          child: SizedBox(
                            height: 300, // Adjusted card height
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<String?>(
                                    future: _getImage(product['imageurl']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Placeholder();
                                        } else {
                                          return Center(
                                            child: Image.network(
                                              snapshot.data ??
                                                  'https://via.placeholder.com/150',
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Placeholder();
                                              },
                                              width: 300,
                                              height: 150,
                                            ),
                                          );
                                        }
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product['ProductName'] ?? 'Product Name',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs ${product['ProductPrice'] ?? '0.0'}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            const Color(0xff374366),
                                        radius: 20.0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.add_shopping_cart_rounded,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            db.addToCart(uid, product);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<String?> _getImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return imageUrl;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
