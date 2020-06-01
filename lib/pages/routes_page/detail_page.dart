import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import '../../models/shuttle_stop.dart';
import '../map_page/states/loaded_map.dart';
import 'widgets/panel.dart';
import 'widgets/popup.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final Map<int, ShuttleStop> routeStops;
  final Color routeColor;
  final ThemeData theme;

  DetailPage(
      {this.title,
      this.polyline,
      this.routeStops,
      this.routeColor,
      this.theme});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PopupController _popupLayerController = PopupController();
  Map<LatLng, ShuttleStop> markerMap = {};

  List<Marker> _createStops(Map<int, ShuttleStop> shuttleStops) {
    var markers = <Marker>[];
    shuttleStops.forEach((key, value) {
      markers.add(value.getMarker());
      markerMap[value.getLatLng] = value;
    });

    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = widget.theme.bottomAppBarColor == Colors.black;
    var _panelHeightOpen = MediaQuery.of(context).size.height * .45;
    var markers = _createStops(widget.routeStops);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.width * 0.115),
          child: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: widget.routeColor,
          ),
        ),
        body: SlidingUpPanel(
          panelBuilder: (sc) => Panel(
            scrollController: sc,
            routeColor: widget.routeColor,
            routeStops: widget.routeStops,
            theme: widget.theme,
          ),
          maxHeight: _panelHeightOpen,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
          parallaxEnabled: true,
          parallaxOffset: 0.25,
          body: Column(
            children: [
              /// Map
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                      nePanBoundary: LatLng(42.78, -73.63),
                      swPanBoundary: LatLng(42.68, -73.71),
                      center: LatLng(42.719, -73.6767),
                      zoom: 13.9,
                      maxZoom: 16, // max you can zoom in
                      minZoom: 13, // min you can zoom out
                      plugins: [PopupMarkerPlugin()],
                      onTap: (_) => _popupLayerController.hidePopup()),
                  layers: [
                    TileLayerOptions(
                      backgroundColor: widget.theme.bottomAppBarColor,
                      urlTemplate:
                          isDarkMode ? LoadedMap.darkLink : LoadedMap.lightLink,
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                    PolylineLayerOptions(polylines: widget.polyline),
                    MarkerLayerOptions(markers: markers),
                    PopupMarkerLayerOptions(
                        markers: markers,
                        popupSnap: PopupSnap.top,
                        popupController: _popupLayerController,
                        popupBuilder: (_, marker) {
                          return Popup(
                            marker: marker,
                            markerMap: markerMap,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
