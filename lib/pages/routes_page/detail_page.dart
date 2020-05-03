import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong/latlong.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_stop.dart';
import '../map_page/map_states/loaded_map.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final List<dynamic> stops;
  final List<int> ids;
  final Color color;

  DetailPage({this.title, this.polyline, this.stops, this.ids, this.color});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  MapController mapController = MapController();

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

  List<Marker> _createStops(List<dynamic> stopsJSON) {
    var markers = <Marker>[];

    for (var stopJSON in stopsJSON) {
      var stop = ShuttleStop.fromJson(stopJSON);
      if (widget.ids.contains(stop.id)) {
        markers.add(stop.getMarker(animatedMapMove));
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, theme) {
      var isDarkMode = theme.bottomAppBarColor == Colors.black;
      return PlatformScaffold(
          appBar: PlatformAppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: widget.color,
              ios: (_) => CupertinoNavigationBarData(
                  actionsForegroundColor: Colors.white)),
          body: Stack(children: <Widget>[
            Column(
              children: [
                /// Map
                Flexible(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      nePanBoundary: LatLng(42.78, -73.63),
                      swPanBoundary: LatLng(42.68, -73.71),
                      center: LatLng(42.731, -73.6767),
                      zoom: 14,
                      maxZoom: 16, // max you can zoom in
                      minZoom: 13, // min you can zoom out
                    ),
                    layers: [
                      TileLayerOptions(
                        backgroundColor: theme.bottomAppBarColor,
                        urlTemplate: isDarkMode
                            ? LoadedMap.darkLink
                            : LoadedMap.lightLink,
                        subdomains: ['a', 'b', 'c'],
                        tileProvider: CachedNetworkTileProvider(),
                      ),
                      PolylineLayerOptions(polylines: widget.polyline),
                      MarkerLayerOptions(markers: _createStops(widget.stops)),
                    ],
                  ),
                ),
              ],
            ),
            //Attribution(),
          ]));
    });
  }
}
