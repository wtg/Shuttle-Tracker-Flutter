import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong/latlong.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_stop.dart';
import '../map_page/states/loaded_map.dart';
import 'widgets/panel.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final Map<int, ShuttleStop> routeStops;
  final Color routeColor;

  DetailPage({this.title, this.polyline, this.routeStops, this.routeColor});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  MapController mapController = MapController();
  final _markers = <Marker>[];

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _createStops(Map<int, ShuttleStop> shuttleStops,
      [ShuttleStop selected]) {
    setState(() {
      shuttleStops.forEach((key, value) {
        if (selected != null) {
          _markers.add(
            value.getMarker(animatedMapMove, (selected.name == value.name)),
          );
        } else {
          _markers.add(
            value.getMarker(animatedMapMove),
          );
        }
      });
    });
//    return markers;
  }

  @override
  void initState() {
    super.initState();
    _createStops(widget.routeStops);
  }

  LatLng findAvgLatLong(Map<int, ShuttleStop> shuttleStops) {
    var lat = 42.729;
    var long = -73.6758;
    var totalLen = shuttleStops.length;
    if (totalLen != 0) {
      lat = 0;
      long = 0;

      shuttleStops.forEach((key, value) {
        var temp = value.getLatLng;
        lat += temp.latitude;
        long += temp.longitude;
      });

      lat /= totalLen;
      long /= totalLen;
    }

    return LatLng(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      var isDarkMode = theme.getTheme.bottomAppBarColor == Colors.black;

      var mapCenter = findAvgLatLong(widget.routeStops);
      return Material(
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            leading: Material(
              child: Container(
                color: theme.getTheme.appBarTheme.color,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: theme.getTheme.hoverColor,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: theme.getTheme.hoverColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: theme.getTheme.appBarTheme.color,
            ios: (_) => CupertinoNavigationBarData(
                actionsForegroundColor: Colors.white),
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    nePanBoundary: LatLng(42.78, -73.63),
                    swPanBoundary: LatLng(42.68, -73.71),
                    center: mapCenter,
                    zoom: 13.9,
                    maxZoom: 16, // max you can zoom in
                    minZoom: 13, // min you can zoom out
                  ),
                  layers: [
                    TileLayerOptions(
                      backgroundColor: theme.getTheme.bottomAppBarColor,
                      urlTemplate:
                          isDarkMode ? LoadedMap.darkLink : LoadedMap.lightLink,
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                    PolylineLayerOptions(polylines: widget.polyline),
                    MarkerLayerOptions(
                      markers: _markers,
                    ),
                  ],
                ),
              ),
              Divider(
                color: widget.routeColor,
                thickness: 4,
              ),
              Flexible(
                child: Panel(
                  routeColor: widget.routeColor,
                  routeStops: widget.routeStops,
                  animate: animatedMapMove,
                  changeMarker: _createStops,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/*
  LatLng _getCentroid(List<ShuttleStop> routeStops) {
    LatLng centroid = LatLng(0, 0);
    double signedArea = 0.0;
    double x0 = 0.0; // Current vertex X
    double y0 = 0.0; // Current vertex Y
    double x1 = 0.0; // Next vertex X
    double y1 = 0.0; // Next vertex Y
    double a = 0.0;

    int i = 0;
    for (i = 0; i < routeStops.length; ++i) {
      x0 = routeStops[i].getLatLng.latitude;
      y0 = routeStops[i].getLatLng.longitude;
      x1 = routeStops[(i + 1) % routeStops.length].getLatLng.latitude;
      ;
      y1 = routeStops[(i + 1) % routeStops.length].getLatLng.longitude;
      a = x0 * y1 - x1 * y0;
      signedArea += a;
      centroid.latitude += (x0 + x1) * a;
      centroid.longitude += (y0 + y1) * a;
    }

    signedArea *= 0.5;
    centroid.latitude /= (6.0 * signedArea);
    centroid.longitude /= (6.0 * signedArea);

    return centroid;
  }
  */

//
//      var header = ClipRRect(
//        borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
//        child: Container(
//          color: widget.routeColor,
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//                height: 20.0,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    width: 30,
//                    height: 5,
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    'Shuttle Stops',
//                    style: TextStyle(
//                      fontWeight: FontWeight.normal,
//                      color: Colors.white,
//                      fontSize: 24.0,
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//            ],
//          ),
//        ),
//      );
