import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

Widget buildInitialState() {
  return Column(
    children: [
      Flexible(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(42.73, -73.6767),
            zoom: 14,
            maxZoom: 20,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              tileProvider: CachedNetworkTileProvider(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildLoadedState(routes, location, stops, updates) {
  return Stack(children: <Widget>[
    Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(42.73, -73.6767),
              zoom: 14,
              maxZoom: 20,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                tileProvider: CachedNetworkTileProvider(),
              ),
              PolylineLayerOptions(polylines: routes),
              MarkerLayerOptions(markers: location),
              MarkerLayerOptions(markers: stops),
              MarkerLayerOptions(markers: updates),
            ],
          ),
        ),
      ],
    ),
    Positioned(
      height: 50,
      width: 400,
      bottom: 1,
      child: Opacity(
        opacity: 0.8,
            child: Container(
              color: Colors.white,
              child: HtmlWidget(
                  """<h5>Map tiles by <a href="http://stamen.com">Stamen Design</a>, under 
                  <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by 
                  <a href="http://openstreetmap.org">OpenStreetMap</a>, under 
                  <a href="http://www.openstreetmap.org/copyright">ODbL</a>. </h5>""",
                  hyperlinkColor: Colors.blue,),
            ),
          
      ),
    ),
    Positioned(
      height: 100,
      width: 100,
      bottom: 50,
      left: 10,
      child: Opacity(
        opacity: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            child: ListView(
              children: <Widget>[
                Text('LINE TEST 1'),
                Text('LINE TEST 2'),
                Text('LINE TEST 3'),
                Text('LINE TEST 4'),
                Text('LINE TEST 5'),
                Text('LINE TEST 6'),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ),
    )
  ]);
}

Widget buildErrorState(String message) {
  return Center(
    child: Text(message),
  );
}
