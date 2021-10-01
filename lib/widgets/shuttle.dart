import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'shuttle_svg.dart';

class Shuttle extends StatelessWidget {
  final dynamic animatedMapMove;
  final BuildContext context;
  final ShuttleSVG svg;
  final int vehicleId;
  final LatLng getLatLng;
  final num heading;

  Shuttle(
      {@required this.animatedMapMove,
      @required this.context,
      @required this.svg,
      @required this.vehicleId,
      @required this.getLatLng,
      @required this.heading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: RotationTransition(
          turns: AlwaysStoppedAnimation((heading - 45) / 360), child: svg),
    );
  }
}
