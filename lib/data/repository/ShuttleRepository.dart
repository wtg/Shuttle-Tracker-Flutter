import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/data/provider/ShuttleApiProvider.dart';
import 'package:flutter_shuttletracker/data/provider/ShuttleLocalProvider.dart';

class ShuttleRepository {
  var _shuttleProvider = ShuttleApiProvider();
  //var _shuttleProvider = ShuttleLocalProvider();

  Future<List<Polyline>> fetchRoutes() async => _shuttleProvider.fetchRoutes();
  Future<List<Marker>> fetchStops() async => _shuttleProvider.fetchStops();
  Future<List<Marker>> fetchUpdates() async => _shuttleProvider.fetchUpdates();
  Future<List<Marker>> fetchLocation() async =>
      _shuttleProvider.fetchLocation();
}
