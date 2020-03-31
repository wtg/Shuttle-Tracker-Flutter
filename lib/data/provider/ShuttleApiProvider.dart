import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/ShuttleImage.dart';
import '../../models/ShuttleRoute.dart';
import '../../models/ShuttleStop.dart';
import '../../models/ShuttleVehicle.dart';

/// This class contains methods for providing data to Repository
class ShuttleApiProvider {
  /// Boolean to determine if the app is connected to network
  bool isConnected;

  /// List of all stops that will be displayed on MapPage
  List<Marker> stops = [];

  /// List of all routes that will be displayed on MapPage
  List<Polyline> routes = [];

  /// List of all updates (shuttles) that will be displayed on MapPage
  List<Marker> updates = [];

  /// Map of with the route number as key and color of that route as the value
  final Map<int, Color> _colors = {};

  /// Map of with name of route as key and ShuttleImage as the value
  final Map<String, ShuttleImage> _mapkey = {};

  /// List of all ids
  final List<int> _ids = [];

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
    print("App is connected to $type API: $isConnected");
    return jsonDecoded;
  }

  bool get getIsConnected => isConnected;

  /// Getter method for list of widgets used in mapkey Container
  Map<String, ShuttleImage> get getMapkey {
    Map<String, ShuttleImage> mapkey = {};
    _mapkey.forEach((key, value) => mapkey[key] = value);
    _mapkey.clear();
    return mapkey;
  }

  /// Getter method to retrieve the list of routes
  Future<List<Polyline>> get getRoutes async {
    final routesJSON = await fetch('routes');

    for (var routeJSON in routesJSON) {
      if (ShuttleRoute.fromJson(routeJSON).active &&
          ShuttleRoute.fromJson(routeJSON).enabled) {
        _mapkey[ShuttleRoute.fromJson(routeJSON).name] =
            ShuttleImage(svgColor: ShuttleRoute.fromJson(routeJSON).color);
        _ids.addAll(ShuttleRoute.fromJson(routeJSON).stopIds);
        routes.add(createRoute(routeJSON));
        for (var schedule in ShuttleRoute.fromJson(routeJSON).schedules) {
          _colors[schedule.routeId] = ShuttleRoute.fromJson(routeJSON).color;
        }
      }
    }
    return routes;
  }

  /// Getter function to retrieve the list of stops
  Future<List<Marker>> get getStops async {
    final stopsJSON = await fetch('stops');

    for (var stopJSON in stopsJSON) {
      if (_ids.contains(ShuttleStop.fromJson(stopJSON).id)) {
        stops.add(createStop(stopJSON));
      }
    }
    _ids.clear();
    return stops;
  }

  /// Getter function to retrieve the list of updated shuttles
  Future<List<Marker>> get getUpdates async {
    final updatesJSON = await fetch('updates');

    for (var updateJSON in updatesJSON) {
      updates.add(createUpdate(updateJSON, _colors));
    }
    _colors.clear();
    return updates;
  }

  /// Getter method to retrived location of user
  Future<List<Marker>> get getLocation async {
    var lat = 0.00;
    var lng = 0.00;
    List<Marker> location = [];

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

    location = [
      Marker(
          point: LatLng(lat, lng),
          width: 10.0,
          height: 10.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
  }
}

/// Helper function to create local JSON file
Future createJSONFile(String fileName, http.Response response) async {
  if (response.statusCode == 200) {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.json');
    await file.writeAsString(response.body);
  }
}

/// Helper function to create Polyline type object for getRoutes
Polyline createRoute(Map<String, dynamic> routeJSON) {
  var route = ShuttleRoute.fromJson(routeJSON);
  return Polyline(
    points: route.points,
    strokeWidth: route.width,
    color: route.color,
  );
}

/// Helper function to create Marker type object for getStops
Marker createStop(Map<String, dynamic> routeJSON) {
  var stop = ShuttleStop.fromJson(routeJSON);
  return Marker(
      point: stop.getLatLng,
      width: 10.0,
      height: 10.0,
      builder: (ctx) => Image.asset('assets/img/circle.png'));
}

/// Helper function to create Marker type object for getUpdates
Marker createUpdate(Map<String, dynamic> updateJSON, Map<int, Color> colors) {
  var shuttle = ShuttleVehicle.fromJson(updateJSON);

  if (colors[shuttle.routeId] != null) {
    shuttle.setColor = colors[shuttle.routeId];
  } else {
    shuttle.setColor = Colors.white;
  }

  return Marker(
      point: shuttle.getLatLng,
      width: 30.0,
      height: 30.0,
      builder: (ctx) => RotationTransition(
          turns: AlwaysStoppedAnimation((shuttle.heading - 45) / 360),
          child: shuttle.image.getSVG));
}
