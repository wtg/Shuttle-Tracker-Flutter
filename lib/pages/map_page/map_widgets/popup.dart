import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'triangle_painer.dart';

class Popup extends StatefulWidget {
  final Marker marker;

  Popup(this.marker);

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                top: 100,
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
            Text(
              "Popup for a marker!",
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              "Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}",
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              "Marker size: ${widget.marker.width}, ${widget.marker.height}",
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
