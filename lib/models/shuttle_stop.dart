import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../blocs/stops_ontap/stops_ontap_bloc.dart';
import '../widgets/custom_bottom_sheet.dart';
import 'shuttle_point.dart';

class ShuttleStop extends ShuttlePoint {
  /// ID associated with stop
  int id;

  /// Name of the stop
  String name;

  /// Timestamp of when stop was created
  String created;

  /// Timestamp ofr when stop was updated
  String updated;

  /// Brief description of the stop
  String description;

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
      StopsOntapBloc bloc}) {
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
        if (context != null) {
          showBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            context: context,
            builder: (_) => CustomBottomSheet(
              markerName: name,
            ),
          );
        }

        if (bloc != null) {
          bloc.add(MapStopTapped(stopName: name));
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
      {dynamic animatedMapMove,
      BuildContext context,
      ThemeData theme,
      StopsOntapBloc bloc}) {
    var selected = false;
    return Marker(
        width: 44.0,
        height: 44.0,
        point: getLatLng,
        builder: (ctx) => bloc != null
            ? BlocBuilder<StopsOntapBloc, String>(
                bloc: bloc,
                builder: (context, stopName) {
                  if (stopName == name) {
                    selected = true;
                  }
                  return _getGesture(
                      animatedMapMove: animatedMapMove,
                      selected: selected,
                      theme: theme,
                      bloc: bloc);
                })
            : _getGesture(
                animatedMapMove: animatedMapMove,
                context: context,
                selected: selected,
                theme: theme,
              ));
  }
}
