import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../provider/ShuttleApiProvider.dart';
//import '../provider/ShuttleLocalProvider.dart';

/// Repo class that retrieves data from provider class methods and
/// distributes the data to BLoC pattern
class ShuttleRepository {
  final _shuttleProvider = ShuttleApiProvider();
  //final _shuttleProvider = ShuttleLocalProvider();

  Future<List<Polyline>> get getRoutes async => _shuttleProvider.getRoutes;
  Future<List<Marker>> get getStops async => _shuttleProvider.getStops;
  Future<List<Marker>> get getUpdates async => _shuttleProvider.getUpdates;
  Future<List<Marker>> get getLocation async => _shuttleProvider.getLocation;
  List<Widget> get getMapkey => _shuttleProvider.getMapkey;
}
