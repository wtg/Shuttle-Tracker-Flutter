import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../../models/shuttle_stop.dart';
import 'triangle_painter.dart';

class Popup extends StatefulWidget {
  final Marker marker;
  final Map<LatLng, ShuttleStop> markerMap;

  Popup({this.marker, this.markerMap});

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Icon(Icons.add),
                ),
                _cardDescription(context),
              ],
            ),
            Positioned(
                left: 80,
                top: 10,
                child: CustomPaint(
                  size: Size(15.0, 10),
                  painter: TrianglePainter(isDown: true, color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              "Stop: ${widget.markerMap[widget.marker.point].name}",
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
