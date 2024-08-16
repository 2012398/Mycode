import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/db.dart';
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
          final orderId = order['data']['OrderId'];
          final status = order['data']['Status'] ?? 'Pending';

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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: status == 'Approved' ? Colors.green :
                    (status == 'Rejected' ? Colors.red : Colors.blue),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final newStatus = status == 'Approved' ? 'Reject' : 'Approved';
                            approveOrder(orderId, newStatus);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                status == 'Approved' ? 'Approved' : 'Approve',
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff374366),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final newStatus = status == 'Rejected' ? 'Approve' : 'Rejected';
                            approveOrder(orderId, newStatus);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                status == 'Rejected' ? 'Rejected' : 'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff374366),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> approveOrder(String orderId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('${db.dblink}/approve'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'orderId': orderId, 'status': status}),
      );

      if (response.statusCode == 200) {
        // Refresh orders to reflect the updated status
        fetchOrders();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order Status Updated successfully!'),
          ),
        );
      } else {
        final errorMsg = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update order: $errorMsg'),
          ),
        );
      }
    } catch (e) {
      print('Error updating order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating order. Please try again later.'),
        ),
      );
    }
  }
}
