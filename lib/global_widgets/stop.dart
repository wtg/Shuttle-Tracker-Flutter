import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import '../pages/map_page/widgets/eta_panel.dart';
import 'shuttle_arrow.dart';

class Stop extends StatelessWidget {
  final dynamic animatedMapMove;
  final BuildContext context;
  final ShuttleSVG svg;
  final int vehicleId;
  final LatLng getLatLng;
  final num heading;

  Stop(
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
        animatedMapMove(getLatLng, 14.2);
        print('Shuttle $vehicleId clicked on');
        if (context != null) {
          showBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              context: context,
              builder: (_) => ETAPanel(
                    markerName: 'Bus ${vehicleId.toString()}',
                  ));
        }
      },
      child: RotationTransition(
          turns: AlwaysStoppedAnimation((heading - 45) / 360), child: svg),
    );
  }
}
