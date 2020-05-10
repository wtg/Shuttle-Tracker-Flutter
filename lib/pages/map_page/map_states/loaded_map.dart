import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
//import 'package:flutter_shuttletracker/pages/map_page/map_widgets/popup.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../models/shuttle_image.dart';
import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';
import '../../../models/shuttle_update.dart';
import '../map_widgets/attribution.dart';
import '../map_widgets/mapkey.dart';

class LoadedMap extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleStop> stops;
  final List<ShuttleUpdate> updates;
  final LatLng location;

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';

  LoadedMap({this.routes, this.location, this.stops, this.updates});

  @override
  _LoadedMapState createState() => _LoadedMapState();
}

class _LoadedMapState extends State<LoadedMap> with TickerProviderStateMixin {
  MapController _mapController = MapController();
  PanelController _panelController = PanelController();
  //PopupController _popupLayerController = PopupController();

  /// Map of with the route number as key and color of that route as the value
  Map<int, Color> _colors = {};

  /// Map of with name of route as key and ShuttleImage as the value
  Map<String, ShuttleImage> _mapkey = {};

  /// List of all ids
  List<int> _ids = [];

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
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

  List<Polyline> _createRoutes(List<ShuttleRoute> routes, List<int> _ids,
      Map<String, ShuttleImage> _mapkey, Map<int, Color> _colors) {
    var polylines = <Polyline>[];

    for (var route in routes) {
      if (route.active && route.enabled) {
        _mapkey[route.name] = ShuttleImage(svgColor: route.color);
        _ids.addAll(route.stopIds);
        polylines.add(route.getPolyline);
        for (var schedule in route.schedules) {
          _colors[schedule.routeId] = route.color;
        }
      }
    }
    //print("Number of routes on map: ${polylines.length}");
    return polylines;
  }

  List<Marker> _createStops(List<ShuttleStop> stops) {
    var markers = <Marker>[];

    for (var stop in stops) {
      if (_ids.contains(stop.id)) {
        markers.add(stop.getMarker(animatedMapMove));
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createUpdates(
      List<ShuttleUpdate> updates, Map<int, Color> colors) {
    var markers = <Marker>[];

    for (var update in updates) {
      if (colors[update.routeId] != null) {
        update.setColor = colors[update.routeId];
      } else {
        update.setColor = Colors.white;
      }

      markers.add(update.getMarker);
    }
    //print("Number of shuttles on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createLocation(LatLng coordinates) {
    var location = <Marker>[
      Marker(
          point: coordinates,
          width: 12.0,
          height: 12.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
  }

  @override
  Widget build(BuildContext context) {
    var routes = _createRoutes(widget.routes, _ids, _mapkey, _colors);
    var updates = _createUpdates(widget.updates, _colors);
    var stops = _createStops(widget.stops);
    var location = _createLocation(widget.location);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, theme) {
        var isDarkMode = theme.getTheme.bottomAppBarColor == Colors.black;
        return Stack(children: <Widget>[
          Column(
            children: [
              /// Map
              Flexible(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    nePanBoundary: LatLng(42.78, -73.63),
                    swPanBoundary: LatLng(42.68, -73.71),
                    center: LatLng(42.729, -73.6758),
                    zoom: 14,
                    maxZoom: 16, // max you can zoom in
                    minZoom: 13, // min you can zoom out
                    //plugins: [PopupMarkerPlugin()],
                    //onTap: (_) => _popupLayerController.hidePopup(),
                  ),
                  layers: [
                    TileLayerOptions(
                      backgroundColor: theme.getTheme.bottomAppBarColor,
                      urlTemplate:
                          isDarkMode ? LoadedMap.darkLink : LoadedMap.lightLink,
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                    PolylineLayerOptions(polylines: routes),
                    MarkerLayerOptions(markers: updates),
                    MarkerLayerOptions(markers: stops),
                    MarkerLayerOptions(markers: location),
                    /*
                      PopupMarkerLayerOptions(
                          markers: stops,
                          popupSnap: PopupSnap.top,
                          popupController: _popupLayerController,
                          popupBuilder: (BuildContext _, Marker marker) {
                    
                            return Popup(marker);
                          }),
                      */
                  ],
                ),
              ),
            ],
          ),
          Attribution(),
          Mapkey(
            mapkey: _mapkey,
          ),
        ]);
      },
    );
  }
}
