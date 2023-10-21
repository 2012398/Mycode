import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(40, 40),
                  bottomRight: Radius.elliptical(40, 40)),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset("images/welcome.png")),
          ),
        ],
      ),
    );
  }
}
