import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'ShuttleApiProvider.dart';

class ShuttleLocalProvider extends ShuttleApiProvider{

  @override
  Future fetch(String fileName) async {
    List<dynamic> jsonDecoded = json
        .decode(await rootBundle.loadString('assets/json_test/$fileName.json'));
    return jsonDecoded;
  }

  
}

