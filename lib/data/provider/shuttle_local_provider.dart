/*
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'shuttle_api_provider.dart';

/// Provider class for testing via local JSON data
class ShuttleLocalProvider extends ShuttleApiProvider {
  @override
  Future<List<dynamic>> fetch(String fileName) async {
    List<dynamic> jsonDecoded;
    try {
      jsonDecoded = json.decode(
          await rootBundle.loadString('assets/json_test/$fileName.json'));
      isConnected = true;
    } catch (e) {
      print(e);
      isConnected = false;
    }
    return jsonDecoded;
  }
}
*/
