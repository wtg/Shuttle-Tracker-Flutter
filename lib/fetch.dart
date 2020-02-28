import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_shuttletracker/classes/ShuttleRoute.dart';


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
    
    markers.add(
      Marker(
        point: LatLng(lat,lng)
      )
    );
  }

  return markers;
}