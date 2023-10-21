import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/menu_screen1.dart';
import 'package:fyp/signin_screen.dart';
import 'package:fyp/splash.dart';

void main() {
  runApp(const FypApp());
}

class FypApp extends StatelessWidget {
  const FypApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Babybloom",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Signin(),
    );
  }
}
