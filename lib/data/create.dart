import 'package:flutter_shuttletracker/models/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/models/ShuttleStop.dart';
import 'package:flutter_shuttletracker/models/ShuttleVehicle.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
