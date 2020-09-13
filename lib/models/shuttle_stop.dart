import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../blocs/on_tap/on_tap_bloc.dart';
import '../blocs/on_tap_eta/on_tap_eta_bloc.dart';
import '../pages/map_page/widgets/eta_panel.dart';
import 'shuttle_point.dart';

class ShuttleStop extends ShuttlePoint {
  /// ID associated with stop
  final int id;

  /// Name of the stop
  final String name;

  /// Timestamp of when stop was created
  final String created;

  /// Timestamp ofr when stop was updated
  final String updated;

  /// Brief description of the stop
  final String description;

  /// Whether or not the stop has been selected
  bool selected;

  /// Uses a super constructor to define lat/lng attributes
  ShuttleStop({
    latitude,
    longitude,
    this.id,
    this.name,
    this.created,
    this.updated,
    this.description,
  }) : super(latitude: latitude, longitude: longitude);

  factory ShuttleStop.fromJson(Map<String, dynamic> json) {
    return ShuttleStop(
      latitude: json['latitude'],
      longitude: json['longitude'],
      id: json['id'],
      name: json['name'],
      created: json['created'],
      updated: json['updated'],
      description: json['description'],
    );
  }

  Widget _getGesture(
      {dynamic animatedMapMove,
      bool selected,
      BuildContext context,
      ThemeData theme,
      OnTapBloc bloc,
      int index}) {
    var selectedAsset = ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.green[400], BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop.png',
        width: 20,
        height: 20,
      ),
    );
    return GestureDetector(
      onTap: () {
        animatedMapMove(getLatLng, 15.2);
        if (bloc != null) {
          bloc.add(MapStopTapped(stopName: name, index: index));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 15, style: BorderStyle.none),
            shape: BoxShape.circle),
        child: selected
            ? selectedAsset
            : Image.asset(
                'assets/img/stop.png',
              ),
      ),
    );
  }

  Marker getMarker(
      {@required dynamic animatedMapMove,
      BuildContext context,
      ThemeData theme,
      OnTapBloc bloc,
      int index}) {
    var selected = false;
    return Marker(
        width: 44.0,
        height: 44.0,
        point: getLatLng,
        builder: (ctx) => BlocBuilder<OnTapBloc, OnTapState>(
            cubit: bloc,
            builder: (_, state) {
              if (state is TappedState) {
                if (state.stopName == name) {
                  selected = true;
                }
              }
              return _getGesture(
                  animatedMapMove: animatedMapMove,
                  selected: selected,
                  context: context,
                  theme: theme,
                  bloc: bloc,
                  index: index);
            }));
  }

  Marker getEtaMarker(
      {@required dynamic animatedMapMove,
      BuildContext context,
      ThemeData theme,
      OnTapEtaBloc bloc,
      int index}) {
    var selected = false;
    return Marker(
        width: 44.0,
        height: 44.0,
        point: getLatLng,
        builder: (ctx) => BlocBuilder<OnTapEtaBloc, OnTapEtaState>(
            cubit: bloc,
            builder: (_, state) {
              if (state is MainTappedState) {
                if (state.stopName == name) {
                  selected = true;
                }
              }
              return _getEtaGesture(
                  animatedMapMove: animatedMapMove,
                  selected: selected,
                  context: context,
                  theme: theme,
                  bloc: bloc,
                  index: index);
            }));
  }

  Widget _getEtaGesture(
      {dynamic animatedMapMove,
      bool selected,
      BuildContext context,
      ThemeData theme,
      OnTapEtaBloc bloc,
      double eta,
      int index}) {
    var selectedAsset = ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.green[400], BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop.png',
        width: 20,
        height: 20,
      ),
    );

    return GestureDetector(
      onTap: () {
        animatedMapMove(getLatLng, 14.2);
        if (context != null) {
          showBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              context: context,
              builder: (_) => ETAPanel(
                    markerName: '$name',
                  ));
        }
        //TODO: CHANGING MARKER FROM NORMAL TO GREEN CAUSES MAP TO REFRESH

        /*
        if (bloc != null) {
          bloc.add(MainMapStopTapped(name: name, stopEta: eta, index: index));
        }
        */
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 15, style: BorderStyle.none),
            shape: BoxShape.circle),
        child: selected
            ? selectedAsset
            : Image.asset(
                'assets/img/stop.png',
              ),
      ),
    );
  }
}
