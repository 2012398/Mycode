// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, prefer_typing_uninitialized_variables

import 'dart:convert';

// import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/menu_screen1.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

bool result = false;
double totalPrice = 0;
double sum = 0;
double checker = 0;
double total = 0;
var dc = 0;
var cost = 0;
List itemprices = [];
var data;
final user = FirebaseAuth.instance.currentUser!;
final uid = FirebaseAuth.instance.currentUser!.uid;
var formatter = NumberFormat('#,###');

class Checkout extends StatefulWidget {
  // Map<String, dynamic> receivedMap;
  // double total;

  // List items;
  Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    super.initState();
    Getinvo(uid);
    // calculator();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Getinvo(uid);
  }

  var data = {};
  var calc;
  Future<void> Getinvo(String uid) async {
    var url = Uri.parse("${db.dblink}/CartItems:$uid");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        calc = data['Products'];
        _TotalCalc();
      });
    } else {
      print("Error22: ${response.statusCode}");
      print("Response22: ${response.body}");
      throw Exception("Failed to load data");
    }
  }

  void _TotalCalc() {
    setState(() {
      total = 0;
      for (int i = 0; i < data['Products'].length; i++) {
        total = (calc[i]['quantity'] * calc[i]['price']) + total;
      }
    });
  }

  var obj;
  @override
  Widget build(BuildContext context) {
    obj = data['Products'];
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.05, //zawat
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.657, //zawat
              child: (obj == null)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: obj.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(obj[index]['itemName']),
                          subtitle: Text(obj[index]['category']),
                          trailing: Text(formatter
                              .format(
                                  obj[index]['price'] * obj[index]['quantity'])
                              .toString()),
                        );
                      },
                    ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10, //zawat
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                width: MediaQuery.of(context).size.width,
                color: Color(0xfff4f4f4),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Delivery Charges:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        Text(
                          dc.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        Text(
                          formatter.format(total).toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 2, child: clearcart()),
                        // Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(flex: 2, child: checkoutbtn()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkoutbtn() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text('Place Order'),
        onPressed: () {
          placeorder();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => checkoutscreen(
          //       receivedMap: data,
          //       total: total,
          //       items: globals.items,
          //     ),
          //   ),
          // );
        },
        icon: Icon(
          Icons.shopping_cart_checkout,
          size: 24,
        ),
      ),
    );
  }

  Future<void> placeorder() async {
    final String apiUrl = '${db.dblink}/placeorder/$uid';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
    );
    var msg = jsonDecode(response.body);
    if (response.statusCode == 201) {
      print(msg['message']);
      print(msg['orderId']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${msg['message']}, OrderId: ${msg['orderId']}'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuScreen1(),
        ),
      );
    } else {
      print(
          'Failed to add item to cart. Error: ${response.statusCode}\n${response.body}');
    }
    return jsonDecode(response.body);
  }

  Widget clearcart() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        label: Text(
          'Clear Cart',
          style: TextStyle(color: Colors.lightBlue),
        ),
        onPressed: () async {
          result = await db.ClearCart(uid, context);
        },
        icon: Icon(
          Icons.remove_shopping_cart,
          size: 24,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
