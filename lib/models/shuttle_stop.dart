import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../blocs/on_tap/on_tap_bloc.dart';
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

        /// FLUSHBAR
        // if (context != null) {
        //   Flushbar(
        //     margin: EdgeInsets.only(top: 60),
        //     maxWidth: MediaQuery.of(context).size.width * 0.95,
        //     flushbarStyle: FlushbarStyle.FLOATING,
        //     borderRadius: 8,
        //     flushbarPosition: FlushbarPosition.TOP,
        //     message: name,
        //     isDismissible: true,
        //     duration: Duration(seconds: 3),
        //     //animationDuration: Duration(milliseconds: 100),
        //   )..show(context);
        // }

        /// ONTAP FEATURE
        // if (bloc != null) {
        //   bloc.add(MapStopTapped(stopName: name, index: index));
        // }
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
      @required OnTapBloc bloc,
      int index}) {
    var selected = false;
    return Marker(
        width: 44.0,
        height: 44.0,
        point: getLatLng,
        builder: (ctx) => BlocBuilder<OnTapBloc, OnTapState>(
            bloc: bloc,
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
}
