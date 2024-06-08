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
          backgroundColor: const Color(0xff374366),
          title: const Text('Orders'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : orders.isEmpty
                ? const Center(child: Text('No orders found'))
                : ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final List<dynamic> items = order['data']['items'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.shopping_bag,
                              color: Color(0xff374366),
                            ),
                            title: Text(
                              'Order by: ${order['data']['Name']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4.0),
                                Text(
                                  'Total: Rs ${order['data']['subtotal']}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Order ID: ${order['id']}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),

                                // Display each product
                                for (var item in items)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4.0),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: 'Product Name: ',
                                            ),
                                            TextSpan(
                                              text: '${item['itemName']}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: 'Category: ',
                                            ),
                                            TextSpan(
                                              text: '${item['category']}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: 'Quantity: ',
                                            ),
                                            TextSpan(
                                              text: '${item['quantity']}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: 'Price: ',
                                            ),
                                            TextSpan(
                                              text: 'Rs ${item['price']}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Address:  ${order['data']['address']}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      );
                    },
                  ));
  }
}
