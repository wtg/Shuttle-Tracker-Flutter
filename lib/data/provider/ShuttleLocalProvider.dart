import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'ShuttleApiProvider.dart';

/// Provider class for testing via local JSON data
class ShuttleLocalProvider extends ShuttleApiProvider {
  @override
  Future fetch(String fileName) async {
    List<dynamic> jsonDecoded = json
        .decode(await rootBundle.loadString('assets/json_test/$fileName.json'));
    return jsonDecoded;
  }
}
