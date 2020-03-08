import 'ShuttleRoute.dart';
import 'package:flutter_map/flutter_map.dart';

class InitShuttleRoutes {
  List<ShuttleRoute> routes  = [];

  InitShuttleRoutes(this.routes) {
    routes = this.routes;
  }

  //Map getColors() {}

  List<int> getStopIds() {
    List<int> stopIds = [];
    for (var route in routes) {
      stopIds.addAll(route.stopIds);
    }
    return stopIds;
  }

  List<Polyline> getPolylines() {
    List<Polyline> polylines = [];
    for (var route in routes) {
      if(route.enabled && route.active){
        polylines.add(Polyline(
          points: route.points,
          strokeWidth: route.width,
          color: route.color,
        ));
      }
      
    }

    return polylines;
  }
}