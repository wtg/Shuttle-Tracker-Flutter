import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/models/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/models/ShuttleStop.dart';
import 'package:flutter_shuttletracker/models/ShuttleVehicle.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';

class ShuttleLocalProvider {
  List<Marker> stops = [];
  List<Polyline> routes = [];
  List<Marker> updates = [];
  Map<int, Color> colors = {};

  List<int> _ids = [];

  Future fetch(String fileName) async {
    List<dynamic> jsonDecoded = json
        .decode(await rootBundle.loadString('assets/json_test/$fileName.json'));
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

Polyline createRoute(Map<String, dynamic> routeJSON) {
  ShuttleRoute route = ShuttleRoute.fromJson(routeJSON);
  return Polyline(
    points: route.points,
    strokeWidth: route.width,
    color: route.color,
  );
}

Marker createStop(Map<String, dynamic> routeJSON) {
  ShuttleStop stop = ShuttleStop.fromJson(routeJSON);
  return Marker(
      point: stop.getLatLng,
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
