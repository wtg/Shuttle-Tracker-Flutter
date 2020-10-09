import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../blocs/on_tap_bloc/on_tap_bloc.dart';
import '../../global_widgets/stop.dart';
import 'shuttle_point.dart';

// ignore: must_be_immutable
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

  @override
  List<Object> get props => [id, name, created, updated, description];

  Marker getMarker(
      {@required dynamic animatedMapMove,
      bool isRoutesPage,
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
              return Stop(
                animatedMapMove: animatedMapMove,
                selected: selected,
                context: context,
                name: name,
                theme: theme,
                bloc: bloc,
                getLatLng: getLatLng,
                index: index,
                isRoutesPage: isRoutesPage,
              );
            }));
  }
}
