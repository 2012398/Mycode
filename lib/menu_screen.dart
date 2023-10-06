import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF374366),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.shopping_cart_checkout_rounded),
          )
        ],
      ),
    );
  }
}
