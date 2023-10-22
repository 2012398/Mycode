// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDMPjh0btZKCe6WFQ3wEHr29iDcK5U9ij4',
    appId: '1:609947077745:web:89fc6d51c9df98b9719fd0',
    messagingSenderId: '609947077745',
    projectId: 'babylogin-d368e',
    authDomain: 'babylogin-d368e.firebaseapp.com',
    storageBucket: 'babylogin-d368e.appspot.com',
    measurementId: 'G-MS7K3J8SHG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChMGZNg1OdvdKdH6m8y92cpYCu0jRZuaY',
    appId: '1:609947077745:android:e796d17687ef33d3719fd0',
    messagingSenderId: '609947077745',
    projectId: 'babylogin-d368e',
    storageBucket: 'babylogin-d368e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiQagaaTPnY0Ur0zR5zeWQAMr75B1__5Y',
    appId: '1:609947077745:ios:749e1564a2559758719fd0',
    messagingSenderId: '609947077745',
    projectId: 'babylogin-d368e',
    storageBucket: 'babylogin-d368e.appspot.com',
    iosBundleId: 'com.example.fyp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCiQagaaTPnY0Ur0zR5zeWQAMr75B1__5Y',
    appId: '1:609947077745:ios:53762f006485b06c719fd0',
    messagingSenderId: '609947077745',
    projectId: 'babylogin-d368e',
    storageBucket: 'babylogin-d368e.appspot.com',
    iosBundleId: 'com.example.fyp.RunnerTests',
  );
}