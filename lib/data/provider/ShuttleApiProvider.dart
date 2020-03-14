import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/models/ShuttleVehicle.dart';
import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shuttletracker/models/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/models/ShuttleStop.dart';
import 'package:path_provider/path_provider.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class ShuttleApiProvider {
  List<Marker> stops = [];
  List<Polyline> routes = [];
  List<Marker> updates = [];
  Map<int, Color> colors = {};

  List<int> _ids = [];

  Future<List<String>> fetchLocal(String fileName) async {
    List<dynamic> jsonDecoded = [];
    jsonDecoded = json
        .decode(await rootBundle.loadString('assets/test_json/$fileName.json'));
    return jsonDecoded;
  }

  Future fetch(String type) async {
    List<dynamic> jsonDecoded = [];
    http.Client client = http.Client();
    final response = await client.get('https://shuttles.rpi.edu/$type');
    createJSONFile('$type', response);

    if (response.statusCode == 200) {
      jsonDecoded = json.decode(response.body);
    }

    return jsonDecoded;
  }

  Future<List<Polyline>> fetchRoutes() async {
    final routesJSON = await fetch('routes');

    for (var routeJSON in routesJSON) {
      if (ShuttleRoute.fromJson(routeJSON).active &&
          ShuttleRoute.fromJson(routeJSON).enabled) {
        _ids.addAll(ShuttleRoute.fromJson(routeJSON).stopIds);
        routes.add(createRoute(routeJSON));
        for (var schedule in ShuttleRoute.fromJson(routeJSON).schedules) {
          colors[schedule.routeId] = ShuttleRoute.fromJson(routeJSON).color;
        }
      }
    }

    return routes;
  }

  Future<List<Marker>> fetchStops() async {
    final stopsJSON = await fetch('stops');

    for (var stopJSON in stopsJSON) {
      if (_ids.contains(ShuttleStop.fromJson(stopJSON).id)) {
        stops.add(createStop(stopJSON));
      }
    }

    return stops;
  }

  Future<List<Marker>> fetchUpdates() async {
    final updatesJSON = await fetch('updates');

    for (var updateJSON in updatesJSON) {
      updates.add(createUpdate(updateJSON, colors));
    }

    return updates;
  }

  Future<List<Marker>> fetchLocation() async {
    double lat = 0.00;
    double lng = 0.00;
    List<Marker> location = [];

    final GeolocationResult permission =
        await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
          android: LocationPermissionAndroid.fine,
          ios: LocationPermissionIOS.always),
      openSettingsIfDenied: true,
    );

    final LocationResult value = await Geolocation.lastKnownLocation();
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

Future createJSONFile(String fileName, http.Response response) async {
  if (response.statusCode == 200) {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName.json');
    await file.writeAsString(response.body);
  }
}

Polyline createRoute(Map<String, dynamic> routeJSON) {
  return Polyline(
    points: ShuttleRoute.fromJson(routeJSON).points,
    strokeWidth: ShuttleRoute.fromJson(routeJSON).width,
    color: ShuttleRoute.fromJson(routeJSON).color,
  );
}

Marker createStop(Map<String, dynamic> routeJSON) {
  return Marker(
      point: ShuttleStop.fromJson(routeJSON).getLatLng,
      width: 10.0,
      height: 10.0,
      builder: (ctx) => Image.asset('assets/img/circle.png'));
}

Marker createUpdate(Map<String, dynamic> updateJSON, Map<int, Color> colors) {
  ShuttleVehicle shuttle = ShuttleVehicle.fromJson(updateJSON);

  if (colors[shuttle.routeId] != null) {
    shuttle.setImage = colors[shuttle.routeId];
  } else {
    shuttle.setImage = Colors.white;
  }

  return Marker(
      point: shuttle.getLatLng,
      width: 30.0,
      height: 30.0,
      builder: (ctx) => RotationTransition(
          turns: AlwaysStoppedAnimation((shuttle.heading - 45) / 360),
          child: shuttle.image.getSVG));
}
