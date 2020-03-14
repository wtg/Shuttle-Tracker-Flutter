import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/data/provider/ShuttleApiProvider.dart';

class ShuttleRepository {
  ShuttleApiProvider _shuttleApiProvider = ShuttleApiProvider();

  Future<List<Polyline>> fetchRoutes() async =>
      _shuttleApiProvider.fetchRoutes();
  Future<List<Marker>> fetchStops() async => _shuttleApiProvider.fetchStops();
  Future<List<Marker>> fetchUpdates() async =>
      _shuttleApiProvider.fetchUpdates();
  Future<List<Marker>> fetchLocation() async =>
      _shuttleApiProvider.fetchLocation();
}
