import 'dart:convert';
import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shuttletracker/models/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/models/ShuttleStop.dart';
import 'package:flutter_shuttletracker/create.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShuttleRepository {
  List<Marker> stops = [];
  List<Polyline> routes = [];
  List<Marker> updates = [];
  
  List<int> _ids = [];
  Map<int, Color> _colors = {};

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
          _colors[schedule.id] = ShuttleRoute.fromJson(routeJSON).color;
        }
      }
    }

    return routes;
  }

  Future<List<Marker>> fetchStops() async {
    final stopsJSON = await fetch('stops');
    print(_ids);
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
      updates.add(createUpdate(updateJSON));
    }

    return updates;
  }

  Future<List<Marker>> fetchLocation() async {
    double lat = 0.00;
    double lng = 0.00;
    List<Marker> location = [];

    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
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
}
