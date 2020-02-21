import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocation/geolocation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LocationData> _locations = [];
  List<StreamSubscription<dynamic>> _subscriptions = [];
  
  getPermission() async {
    final GeolocationResult result = await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always,
      ),
    openSettingsIfDenied: true,
    );

  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(42.73029109316892, -73.676558732986),
                  zoom: 14.5,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
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

class LocationData {
  LocationData({
    @required this.id,
    this.result,
    @required this.origin,
    @required this.color,
    @required this.createdAtTimestamp,
    this.elapsedTimeSeconds,
  });

  final int id;
  final LocationResult result;
  final String origin;
  final Color color;
  final int createdAtTimestamp;
  final int elapsedTimeSeconds;
}