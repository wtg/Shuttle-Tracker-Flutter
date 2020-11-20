import 'dart:convert';

import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

import '../../data/models/shuttle_route.dart';
import '../../data/models/shuttle_stop.dart';
import '../../data/models/shuttle_update.dart';

/// This class contains methods for providing data to Repository
class ShuttleApiProvider {
  /// Boolean to determine if the app is connected to network
  bool isConnected;

  /// This function will fetch the data from the JSON API and return a decoded
  Future<http.Response> fetch(String type) async {
    var client = http.Client();
    http.Response response;
    try {
      response = await client.get('https://shuttles.rpi.edu/$type');

      if (response.statusCode == 200) {
        isConnected = true;
      }
    } // TODO: MODIFY LOGIC HERE
    catch (error) {
      isConnected = false;
    }
    //print("App has polled $type API: $isConnected");
    return response;
  }

  bool get getIsConnected => isConnected;

  /// Getter method to retrieve the list of routes
  Future<List<ShuttleRoute>> getRoutes() async {
    var response = await fetch('routes');
    print("ROUTES DATA FETCHED");
    List<ShuttleRoute> routeList = response != null
        ? json
            .decode(response.body)
            .map<ShuttleRoute>((json) => ShuttleRoute.fromJson(json))
            .toList()
        : [];
    return routeList;
  }

  /// Getter method to retrieve the list of stops
  Future<List<ShuttleStop>> getStops() async {
    var response = await fetch('stops');
    List<ShuttleStop> stopsList = response != null
        ? json
            .decode(response.body)
            .map<ShuttleStop>((json) => ShuttleStop.fromJson(json))
            .toList()
        : [];
    return stopsList;
  }

  /// Getter method to retrieve the list of updated shuttles
  Future<List<ShuttleUpdate>> getUpdates() async {
    var response = await fetch('updates');

    List<ShuttleUpdate> updatesList = response != null
        ? json
            .decode(response.body)
            .map<ShuttleUpdate>((json) => ShuttleUpdate.fromJson(json))
            .toList()
        : [];
    return updatesList;
  }

  /// Getter method to retrieved location of user
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

    if (permission.isSuccessful && value.isSuccessful) {
      lat = value.location.latitude;
      lng = value.location.longitude;
    }

    var location = LatLng(lat, lng);

    return location;
  }
}
