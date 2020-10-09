import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
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
      onTap: () {
        // animatedMapMove(getLatLng, 14.2);
        // print('Shuttle $vehicleId clicked on');
        // if (context != null) {
        //   showBottomSheet(
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(25.0),
        //               topRight: Radius.circular(25.0))),
        //       context: context,
        //       builder: (_) => ETAPanel(
        //             markerName: 'Bus ${vehicleId.toString()}',
        //             stopMarker: false,
        //           )); // stopType is false if bus, true otherwise
        // }
      },
      child: RotationTransition(
          turns: AlwaysStoppedAnimation((heading - 45) / 360), child: svg),
    );
  }
}
