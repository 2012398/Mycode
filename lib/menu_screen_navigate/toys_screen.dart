import 'package:flutter/material.dart';
import '../db.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Toys extends StatefulWidget {
  const Toys({super.key});

  @override
  State<Toys> createState() => _ToysState();
}

class _ToysState extends State<Toys> {
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
    Getinvo("Toys");
  }

  @override
  Widget build(BuildContext context) {
    var obj = data['Products'];
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: (obj == null)
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: obj.length,
                  itemBuilder: (context, index) {
                    final product = obj[index];
                    return Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Added padding to the grid items
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['ProductName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2, // Added to limit text to 2 lines
                                  overflow: TextOverflow
                                      .ellipsis, // Added to handle long text
                                ),
                                SizedBox(height: 10), // Added for spacing
                                Text(
                                  'Rs ${product['ProductPrice']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(height: 10), // Added for spacing
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xff374366),
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
                    );
                  },
                ),
        ),
      ),
    );
  }
}
