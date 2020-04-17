import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingMap extends StatefulWidget {
  @override
  _LoadingMapState createState() => _LoadingMapState();
}

class _LoadingMapState extends State<LoadingMap> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
