import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../../global_widgets/shuttle_arrow.dart';
import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_update.dart';
import '../provider/shuttle_api_provider.dart';
//import '../provider/shuttle_local_provider.dart';

/// Repo class that retrieves data from provider class methods and
/// distributes the data to BLoC pattern
class ShuttleRepository {
  final _shuttleProvider = ShuttleApiProvider();

//  void get openSocket => _shuttleProvider.openSocket();
  Future<List<ShuttleRoute>> get getRoutes async =>
      _shuttleProvider.getRoutes();
  Future<List<ShuttleStop>> get getStops async => _shuttleProvider.getStops();
  Future<List<ShuttleUpdate>> get getUpdates async =>
      _shuttleProvider.getUpdates();
  Future<LatLng> get getLocation async => _shuttleProvider.getLocation();
  bool get getIsConnected => _shuttleProvider.getIsConnected;

  Future<AuxiliaryRouteData> getAuxiliaryRouteData() async {
    var routes = await _shuttleProvider.getRoutes();
    var ids = <int>[];
    var legend = <String, ShuttleArrow>{};
    var colors = <int, Color>{};

    for (var route in routes) {
      if (route.active && route.enabled) {
        legend[route.name] = ShuttleArrow(svgColor: route.color);
        ids.addAll(route.stopIds);
        for (var schedule in route.schedules) {
          colors[schedule.routeId] = route.color;
        }
      }
    }

    return AuxiliaryRouteData(ids: ids, legend: legend, colors: colors);
  }
}

class AuxiliaryRouteData {
  final List<int> ids;
  final Map<String, ShuttleArrow> legend;
  final Map<int, Color> colors;

  AuxiliaryRouteData({this.ids, this.legend, this.colors});
}
