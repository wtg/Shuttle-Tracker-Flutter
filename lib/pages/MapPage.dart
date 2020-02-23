import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';


class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  getPermission() async {
    //double lat;
    //double lng;
    final GeolocationResult result = await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always
      ),
      openSettingsIfDenied: true,
    );

    return result;
    /*
    LocationResult value = await Geolocation.lastKnownLocation();

    if(result.isSuccessful && value.isSuccessful){
      print('yeet');
      lat = value.location.latitude;
      lng = value.location.longitude;
      
      print(lat);
      print(lng);
    }

    else{
      lat = 0;
      lng = 0;
      print('nah');
    }

    return [lat,lng];
    */
  }

  @override
  Widget build(BuildContext context) {

    var markers = <Marker>[ //TEST MARKER
      Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(42.73, -73.68),
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.fiber_manual_record),
            color: Colors.orange,
            onPressed: (){
              print('Button Pressed');
            },
          )
        ),
      ),
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(42.73, -73.677),
                  zoom: 14.7,
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
                    markers: markers
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