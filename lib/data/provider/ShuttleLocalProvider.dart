import 'dart:convert';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class ShuttleLocalProvider {
  List<Marker> stops = [];
  List<Polyline> routes = [];
  List<Marker> updates = [];
  Map<int, Color> colors = {};

  //List<int> _ids = [];

  Future<List<String>> fetchLocal(String fileName) async {
    List<dynamic> jsonDecoded = [];
    jsonDecoded = json
        .decode(await rootBundle.loadString('assets/test_json/$fileName.json'));
    return jsonDecoded;
  }
}
