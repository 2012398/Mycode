import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Screens/Cart.dart';
import '../db.dart' as db;

class Bath_accesories extends StatefulWidget {
  const Bath_accesories({Key? key});

  @override
  State<Bath_accesories> createState() => Bath_accesoriesState();
}

class Bath_accesoriesState extends State<Bath_accesories> {
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
    Getinvo("Bath accessories");
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(product['imageurl']),
                              Text(
                                product['ProductName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2, // Limiting to 2 lines
                                overflow:
                                    TextOverflow.ellipsis, // Handling overflow
                              ),
                              SizedBox(height: 10), // Adding space
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rs ${product['ProductPrice']}',
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  const SizedBox(width: 30),
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
                    );
                  },
                ),
        ),
      ),
    );
  }
}
