import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color(0xff374366),
            // decoration: BoxDecoration(shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
