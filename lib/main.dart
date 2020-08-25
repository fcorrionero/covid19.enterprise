import 'package:flutter/material.dart';
import 'package:tracking/Infrastructure/UI/Pages/Components/loader.dart';
import 'package:tracking/Infrastructure/UI/Pages/LoginPage.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(CovidApp());
}

class CovidApp extends StatefulWidget {
  // This widget is the root of your application.
  _CovidAppState createState() => _CovidAppState();
}

class _CovidAppState extends State<CovidApp>
{
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState()
  {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      print(_error.toString());
      throw UnimplementedError();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return MaterialApp(
        title: 'Loading',
        home: Loader(),
      );
    }

    return MaterialApp(
        title: 'Covid Enterprise Tracking',
        home: LoginPage()
    );
  }
}