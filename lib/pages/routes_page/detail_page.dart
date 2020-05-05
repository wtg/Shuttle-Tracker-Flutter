import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_stop.dart';
import '../map_page/map_states/loaded_map.dart';
import 'route_widgets/panel.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final List<ShuttleStop> shuttleStops;
  final List<int> ids;
  final Color routeColor;

  DetailPage(
      {this.title,
      this.polyline,
      this.shuttleStops,
      this.ids,
      this.routeColor});

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

  List<Marker> _createStops(List<ShuttleStop> stops) {
    var markers = <Marker>[];

    for (var stop in stops) {
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
      var _panelHeightOpen = MediaQuery.of(context).size.height * .80;
      return PlatformScaffold(
          appBar: PlatformAppBar(
              title: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              backgroundColor: widget.routeColor,
              ios: (_) => CupertinoNavigationBarData(
                  actionsForegroundColor: Colors.white)),
          body: SlidingUpPanel(
            panelBuilder: (sc) => Panel(
                scrollController: sc,
                routeColor: widget.routeColor,
                shuttleStops: widget.shuttleStops,
                ids: widget.ids),
            maxHeight: _panelHeightOpen,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: Column(
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
                      MarkerLayerOptions(
                          markers: _createStops(widget.shuttleStops)),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
