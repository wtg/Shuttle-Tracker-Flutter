import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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

  /// Uses a super constructor to define lat/lng attributes
  ShuttleStop(
      {latitude,
        longitude,
        this.id,
        this.name,
        this.created,
        this.updated,
        this.description})
      : super(latitude: latitude, longitude: longitude);

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

  Marker getMarker(dynamic animatedMapMove, [BuildContext context]) {
    return Marker(
      width: 44.0,
      height: 44.0,
      point: getLatLng,
      builder: (ctx) => GestureDetector(
        onTap: () {
          animatedMapMove(getLatLng, 14.2);
          print('Stop $name clicked on');
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
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 15, style: BorderStyle.none),
              shape: BoxShape.circle),
          child: Image.asset(
            'assets/img/stop.png',
          ),
        ),
      ),
    );
  }
}
