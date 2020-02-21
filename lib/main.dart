import 'package:flutter/material.dart';
import './pages/HomePage.dart';
import 'package:geolocation/geolocation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_ShuttleTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Flutter_ShuttleTracker',
      ),
    );
  }
  enableLocationServices() async {
    Geolocation.enableLocationServices().then((result) {
      // Request location
    }).catchError((e) {
      // Location Services Enablind Cancelled
    });
  }
}

