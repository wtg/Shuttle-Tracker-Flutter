import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import '../blocs/on_tap_bloc/on_tap_bloc.dart';
import '../pages/map_page/widgets/eta_panel.dart';

class Stop extends StatelessWidget {
  final dynamic animatedMapMove;
  final bool selected;
  final Color selectedColor;
  final BuildContext context;
  final ThemeData theme;
  final OnTapBloc bloc;
  final int index;
  final LatLng getLatLng;
  final String name;
  final bool isRoutesPage;

  Stop(
      {@required this.animatedMapMove,
      @required this.selected,
      @required this.context,
      @required this.theme,
      @required this.bloc,
      @required this.index,
      @required this.getLatLng,
      @required this.name,
      @required this.isRoutesPage,
      @required this.selectedColor});

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  Widget getSelectedAsset() {
    final selectedAsset = ColorFiltered(
      colorFilter:
          ColorFilter.mode(tintColor(selectedColor, 0.5), BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop_thin.png',
        width: 40,
        height: 40,
      ),
    );

    return selectedAsset;
  }

  Widget getDeselectedAsset() {
    final selectedAsset = ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.white, BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop.png',
        width: 25,
        height: 25,
      ),
    );

    return selectedAsset;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animatedMapMove(getLatLng, 15.2);
        if (isRoutesPage) {
          bloc.add(MapStopTapped(stopName: name, index: index));
        } else {
          showBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              context: context,
              builder: (_) => ETAPanel(
                    markerName: '$name',
                    stopMarker: true,
                  ));
        }
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 15, style: BorderStyle.none),
              shape: BoxShape.circle),
          child: selected
              ? getSelectedAsset()
              : getDeselectedAsset() ?? Image.asset(
                  'assets/img/stop.png',
                  width: 25,
                  height: 25,
                )),
    );
  }
}
