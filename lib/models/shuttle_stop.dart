import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

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
      this.name,
      this.created,
      this.updated,
      this.description})
      : super(latitude: latitude, longitude: longitude);

  ShuttleStop.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
    description = json['description'];
  }

  Marker getMarker(dynamic animatedMapMove) => Marker(
      width: 35.0,
      height: 35.0,
      point: getLatLng,
      builder: (ctx) => GestureDetector(
          onTap: () {
            animatedMapMove(getLatLng, 15.0);
            print('Stop $name clicked on');
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 12, style: BorderStyle.none),
                  shape: BoxShape.circle),
              child: Image.asset(
                'assets/img/circle.png',
              ))

          /*
      Container(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 12, style: BorderStyle.none),
                  shape: BoxShape.circle),
              child: Image.asset(
                'assets/img/circle.png',
              ))

*/
          ));
}
