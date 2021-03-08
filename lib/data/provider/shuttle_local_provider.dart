import 'dart:async';
import 'package:http/http.dart' as http;

import 'shuttle_api_provider.dart';

/// Provider class for testing via local JSON data
class ShuttleLocalProvider extends ShuttleApiProvider {
  /// This function will fetch the data from the JSON API and return a decoded
  @override
  Future<http.Response> fetch(String type) async {
    var client = http.Client();
    http.Response response;
    try {
      response = await client.get('http://10.0.2.2:3001/$type');

      if (response.statusCode == 200) {
        isConnected = true;
      }
    } catch (error) {
      isConnected = false;
    }
    return response;
  }
}
