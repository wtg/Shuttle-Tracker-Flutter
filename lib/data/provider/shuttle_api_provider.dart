import 'dart:convert';
import 'dart:io';

import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:latlong/latlong.dart';

/// This class contains methods for providing data to Repository
class ShuttleApiProvider {
  /// Boolean to determine if the app is connected to network
  bool isConnected;

  /// This function will fetch the data from the JSON API and return a decoded
  Future fetch(String type) async {
    var jsonDecoded = [];
    var client = http.Client();
    try {
      final response = await client.get('https://shuttles.rpi.edu/$type');
      createJSONFile('$type', response);

      if (response.statusCode == 200) {
        isConnected = true;
        jsonDecoded = json.decode(response.body);
      }
    } // TODO: MODIFY LOGIC HERE
    catch (error) {
      isConnected = false;
    }
    print("App has polled $type API: $isConnected");
    return jsonDecoded;
  }

  bool get getIsConnected => isConnected;

  /// Getter method to retrieve the list of routes
  Future<List<dynamic>> get getRoutes async => await fetch('routes');

  /// Getter method to retrieve the list of stops
  Future<List<dynamic>> get getStops async => await fetch('stops');

  /// Getter method to retrieve the list of updated shuttles
  Future<List<dynamic>> get getUpdates async => await fetch('updates');

  /// Getter method to retrived location of user
  Future<LatLng> getLocation() async {
    var lat = 0.00;
    var lng = 0.00;

    final permission = await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
          android: LocationPermissionAndroid.fine,
          ios: LocationPermissionIOS.always),
      openSettingsIfDenied: true,
    );

    final value = await Geolocation.lastKnownLocation();
    print(permission);
    print(value);

    if (permission.isSuccessful && value.isSuccessful) {
      lat = value.location.latitude;
      lng = value.location.longitude;
    }

    var location = LatLng(lat, lng);

    return location;
  }

  /// Helper function to create local JSON file
  Future createJSONFile(String fileName, http.Response response) async {
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.json');
      await file.writeAsString(response.body);
    }
  }
}
