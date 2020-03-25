import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/data/provider/ShuttleApiProvider.dart';
//import 'package:flutter_shuttletracker/data/provider/ShuttleLocalProvider.dart';

class ShuttleRepository {
  var _shuttleProvider = ShuttleApiProvider();
  //var _shuttleProvider = ShuttleLocalProvider();

  Future<List<Polyline>> get getRoutes async => _shuttleProvider.getRoutes;
  Future<List<Marker>> get getStops async => _shuttleProvider.getStops;
  Future<List<Marker>> get getUpdates async => _shuttleProvider.getUpdates;
  Future<List<Marker>> get getLocation async => _shuttleProvider.getLocation;
  List<Widget> get getMapkey => _shuttleProvider.getMapkey;
}
