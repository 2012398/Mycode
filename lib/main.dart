import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/educational_resources.dart';
import 'package:fyp/Screens/privacy_policy.dart';
import 'package:fyp/Screens/splash.dart';
import 'Screens/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: Privacypolicy(),
    );
  }
}
