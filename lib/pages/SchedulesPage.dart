import 'package:flutter/material.dart';

class SchedulesPage extends StatefulWidget {
  SchedulesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SchedulesPage'),
      ),
    );
  }
}