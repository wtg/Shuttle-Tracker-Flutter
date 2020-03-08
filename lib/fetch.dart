import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/classes/ShuttleRoute.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'create.dart';

Future<List<ShuttleRoute>> fetchRoutes(http.Client client) async {
  final response = await client.get('https://shuttles.rpi.edu/routes');
  createJSONFile('routes', response);

  var routes = List<ShuttleRoute>();

  if (response.statusCode == 200) {
    var routesJSON = json.decode(response.body);

    for (var routeJSON in routesJSON) {
      routes.add(ShuttleRoute.fromJson(routeJSON));
    }
  }
 
  return routes;
}

Future<List<Marker>> fetchUpdates(http.Client client) async {
  final response = await client.get('https://shuttles.rpi.edu/updates');
  createJSONFile('updates', response);

  List<Marker> updates = [];

  if (response.statusCode == 200) {
    var updatesJSON = json.decode(response.body);

    for (var updateJSON in updatesJSON) {
      updates.add(createUpdate(updateJSON));
    }
  }

  return updates;
}

Future<List<Marker>> fetchStops(http.Client client) async {
  final response = await client.get('https://shuttles.rpi.edu/stops');
  createJSONFile('stops', response);

  var stops = List<Marker>();

  if (response.statusCode == 200) {
    var stopsJSON = json.decode(response.body);

    for (var stopJSON in stopsJSON) {
      stops.add(createStop(stopJSON));
    }
  }

  return stops;
}

Future<List<Marker>> fetchLocation() async {
  double lat = 0.00;
  double lng = 0.00;
  List<Marker> location = [];

  final GeolocationResult result = await Geolocation.requestLocationPermission(
    permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always),
    openSettingsIfDenied: true,
  );

  final LocationResult value = await Geolocation.lastKnownLocation();

  if (result.isSuccessful && value.isSuccessful) {
    lat = value.location.latitude;
    lng = value.location.longitude;
  }

  location = [
    Marker(
        point: LatLng(lat, lng),
        width: 10.0,
        height: 10.0,
        builder: (ctx) => Image.asset('assets/img/user.png'))
  ];

  return location;
}
