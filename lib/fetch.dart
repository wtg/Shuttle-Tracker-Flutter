import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shuttletracker/classes/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/classes/ShuttleStop.dart';
import 'package:tuple/tuple.dart';
import 'create.dart';

Future<Tuple2<List<Polyline>, List<Marker>>> fetchRoutes(http.Client client) async {
  final responseRoutes = await client.get('https://shuttles.rpi.edu/routes');
  final responseStops = await client.get('https://shuttles.rpi.edu/stops');

  createJSONFile('routes', responseRoutes);
  createJSONFile('stops', responseStops);

  List<Marker> stops = [];
  List<Polyline> routes = [];
  List<int> ids = [];

  if (responseRoutes.statusCode == 200 && responseStops.statusCode == 200) {
    var routesJSON = json.decode(responseRoutes.body);
    var stopsJSON = json.decode(responseStops.body);

    for (var routeJSON in routesJSON) {
      if (ShuttleRoute.fromJson(routeJSON).active &&
          ShuttleRoute.fromJson(routeJSON).enabled) {
        ids.addAll(ShuttleRoute.fromJson(routeJSON).stopIds);
        routes.add(createRoute(routeJSON));
      }
    }

    for (var stopJSON in stopsJSON) {
      if (ids.contains(ShuttleStop.fromJson(stopJSON).id)) {
        stops.add(createStop(stopJSON));
      }
    }
  }

  return Tuple2<List<Polyline>, List<Marker>>(routes, stops);
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
