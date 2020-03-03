import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/classes/ShuttleVehicle.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_shuttletracker/classes/ShuttleRoute.dart';
import 'package:flutter_shuttletracker/classes/ShuttleStop.dart';

Future createJSONFile(String fileName, http.Response response) async {

  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$fileName.json');
  await file.writeAsString(response.body);

}


Future <List<Polyline>> fetchRoutes(http.Client client) async {

  final response = await client.get('https://shuttles.rpi.edu/routes');
  createJSONFile('routes', response);

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


Future <List<Marker>> fetchUpdates(http.Client client) async {

  final response = await client.get('https://shuttles.rpi.edu/updates');
  createJSONFile('updates', response);

  var updates = List<Marker>();

  if (response.statusCode == 200){

    var updatesJSON = json.decode(response.body);

    for (var updateJSON in updatesJSON) {

      updates.add(
        Marker(
          point: ShuttleVehicle.fromJson(updateJSON).convertToLatLng(),
          width: 10.0, // width and height do not affect the size of the icon
          height: 10.0,
          builder: (ctx) => RotationTransition(
            turns: AlwaysStoppedAnimation(ShuttleVehicle.fromJson(updateJSON).heading / 360),
            child: Container(
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.navigation),
                color: Colors.black,
                onPressed: (){
                  print('Button Pressed!');
                },
              ),
            )
          )
        )
      );
    }
  }

  return updates;
}

Future <List<Marker>> fetchStops(http.Client client) async {

  final response = await client.get('https://shuttles.rpi.edu/stops');
  createJSONFile('stops', response);

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