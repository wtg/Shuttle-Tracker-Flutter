import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../../data/models/shuttle_route.dart';
import '../../data/models/shuttle_stop.dart';
import '../../data/models/shuttle_update.dart';
import '../../global_widgets/shuttle_svg.dart';
import '../../theme/helpers.dart';
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

  Future<List<ShuttleRoute>> getDarkRoutes() async {
    var routes = await _shuttleProvider.getRoutes();
    var ret = <ShuttleRoute>[];

    for (var route in routes) {
      var darkRoute = route.getDarkRoute();
      ret.add(darkRoute);
    }
    return ret;
  }

  Future<AuxiliaryRouteData> getAuxiliaryRouteData() async {
    var routes = await getRoutes;
    var ids = <int>[];
    var legend = <String, ShuttleSVG>{};
    var darkLegend = <String, ShuttleSVG>{};
    var colors = <int, Color>{};

    for (var route in routes) {
      if (route.active && route.enabled) {
        legend[route.name] = ShuttleSVG(svgColor: route.color);
        darkLegend[route.name] =
            ShuttleSVG(svgColor: shadeColor(route.color, 0.35));
        ids.addAll(route.stopIds);
        for (var schedule in route.schedules) {
          colors[schedule.routeId] = route.color;
        }
      }
    }

    return AuxiliaryRouteData(
        ids: ids, legend: legend, colors: colors, darkLegend: darkLegend);
  }
}

class AuxiliaryRouteData {
  final List<int> ids;
  final Map<String, ShuttleSVG> legend;
  final Map<int, Color> colors;
  final Map<String, ShuttleSVG> darkLegend;

  AuxiliaryRouteData({
    this.ids,
    this.legend,
    this.colors,
    this.darkLegend,
  });
}
