import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_shuttletracker/widgets/ShuttleRoute.dart';



class MapPage extends StatefulWidget {

  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  List<Polyline> _routes = List<Polyline>();
  List<Marker> _markers = List<Marker>();
  
  
  Future <List<Polyline>> fetchRoutes(http.Client client) async {
    final response = await client.get('https://shuttles.rpi.edu/routes');
    
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/routes.json');
    await file.writeAsString(response.body);

    var routes = List<ShuttleRoute>();
    var polylines = List<Polyline>();


    if (response.statusCode == 200){
      var routesJSON = json.decode(response.body);

      for (var routeJSON in routesJSON) {
        routes.add(ShuttleRoute.fromJson(routeJSON));
        polylines.add(Polyline(
          points: ShuttleRoute.fromJson(routeJSON).points,
          strokeWidth: ShuttleRoute.fromJson(routeJSON).width,
          color: ShuttleRoute.fromJson(routeJSON).color,
        ));
      }
    }
    return polylines;
  }

  Future<List<Marker>> getPermission() async {

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
    print(value);
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

  @override
  Widget build(BuildContext context) {
    fetchRoutes(http.Client()).then((value) {
      //setState(() {
      _routes.addAll(value);
     // });
    });
    print(_routes.length);
    
    getPermission().then((value) {
   
      _markers.addAll(value);

    });
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(42.73, -73.677),
                  zoom: 14.4,
                  maxZoom: 16,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: CachedNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(
                    markers: _markers
                  ),
                  PolylineLayerOptions(
                    polylines: _routes
                  )
                ],
              ),
            ),
          ], 
        ),
      ),
    );
  }
}