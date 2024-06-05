import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/db.dart' as db;

class ShowOrders extends StatefulWidget {
  const ShowOrders({super.key});

  @override
  State<ShowOrders> createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  List<dynamic> orders = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('${db.dblink}/orders'));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        orders = responseData['orders'];
      });
    } else {
      // Handle errors
      print('Failed to load orders: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(child: Text('No orders found'))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    // Customize how you display order data
                    return ListTile(
                      title: Text('Order by: ${order['data']['Name']}'),

                      trailing: Text('Order ID: ${order['id']}'),
                      subtitle: Text('Total: Rs ${order['data']['total']}'),
                      // Add more details if needed
                    );
                  },
                ),
    );
  }
}
