import 'package:flutter/material.dart';

import 'package:fyp/splash.dart';

void main() {
  runApp(FypApp());
}

class FypApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Babybloom",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
