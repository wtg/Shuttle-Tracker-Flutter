import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_shuttletracker/classes/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/classes/ShuttleStop.dart';


Future <List<Polyline>> fetchRoutes(http.Client client) async {

  final response = await client.get('https://shuttles.rpi.edu/routes');
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/routes.json');
  await file.writeAsString(response.body);

  var routes = List<Polyline>();

  if (response.statusCode == 200){

    var routesJSON = json.decode(response.body);

    for (var routeJSON in routesJSON) {
      routes.add(Polyline(
        points: ShuttleRoute.fromJson(routeJSON).points,
        strokeWidth: ShuttleRoute.fromJson(routeJSON).width,
        color: ShuttleRoute.fromJson(routeJSON).color,
      ));
    }
  }

  return routes;
}

Future <List<Marker>> fetchStops(http.Client client) async {

  final response = await client.get('https://shuttles.rpi.edu/stops');
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/stops.json');
  await file.writeAsString(response.body);

  var stops = List<Marker>();

  if (response.statusCode == 200){

    var stopsJSON = json.decode(response.body);

    for (var stopJSON in stopsJSON) {
      stops.add(
        Marker(
          point: ShuttleStop.fromJson(stopJSON).convertToLatLng(),
          width: 10.0, // width and height do not affect the size of the icon
          height: 10.0,
          builder: (ctx) => Container(
            child: IconButton(
              iconSize: 17,
              icon: Icon(Icons.fiber_manual_record),
              color: Colors.blue[800],
              onPressed: (){
                print('Button Pressed!');
              },
            ),
          )
        )
      );
    }
  }

  return stops;
}



Future<List<Marker>> fetchLocation() async {

  double lat = 0.00;
  double lng = 0.00;
  var markers = List<Marker>();

  final GeolocationResult result = await Geolocation.requestLocationPermission(
    permission: const LocationPermission(
      android: LocationPermissionAndroid.fine,
      ios: LocationPermissionIOS.always
    ),
    openSettingsIfDenied: true,
  );
  

  final LocationResult value = await Geolocation.lastKnownLocation();

  if(result.isSuccessful && value.isSuccessful){
    lat = value.location.latitude;
    lng = value.location.longitude;
  }
  
  markers = [
    Marker(
      point: LatLng(lat,lng),
      width: 10.0, // width and height do not affect the size of the icon
      height: 10.0,
      builder: (ctx) => Container(
        child: IconButton(
          iconSize: 17,
          icon: Icon(Icons.fiber_manual_record),
          color: Colors.orange,
          onPressed: (){
            print('Button Pressed!');
          },
        ),
      )
    )
  ];
  
  return markers;
}