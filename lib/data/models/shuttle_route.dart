import 'dart:core';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'shuttle_point.dart';
import 'shuttle_schedule.dart';

class ShuttleRoute {
  /// Id for this route
  final int id;

  /// Name of this route
  final String name;

  /// Description of this route
  final String desc;

  /// Bool to determine if route is enabled for semester
  final bool enabled;

  /// Hex color of route
  final Color color;

  /// Width of route outline on map
  final num width;

  /// All stop ids associated with route
  final List<int> stopIds;

  /// Timestamp for when route was created
  final String created;

  /// Timestamp for when route was last updated
  final String updated;

  /// All points required to create the route with respective lat/lng values
  final List<LatLng> points;

  /// Bool to determine if route is active at current period of time
  final bool active;

  /// List of shuttles currently associated with this route
  final List<ShuttleSchedule> schedules;

  /// Bool to determine if route is a favorite or not
  bool favorite;

  ShuttleRoute(
      {this.id,
      this.name,
      this.desc,
      this.enabled,
      this.color,
      this.width,
      this.stopIds,
      this.created,
      this.updated,
      this.points,
      this.active,
      this.schedules,
      this.favorite});

  // Store 2 different versions of a route
  factory ShuttleRoute.fromJson(Map<String, dynamic> json) {
    return ShuttleRoute(
        id: json['id'],
        name: json['name'].toString(),
        desc: json['description'].toString(),
        enabled: json['enabled'],
        color:
            Color(int.parse(json['color'].toString().replaceAll('#', '0xff'))),
        width: (json['width'] as num).toDouble() * 0.7,
        stopIds: List<int>.from(json['stop_ids'] as List),
        created: json['created'],
        updated: json['updated'],
        points: (json['points'] as List)
            .map((i) => ShuttlePoint.fromJson(i).getLatLng)
            .toList(),
        active: json['active'],
        schedules: (json['schedule'] as List)
            .map((i) => ShuttleSchedule.fromJson(i))
            .toList(),
        favorite: false);
  }

  Polyline get getPolyline => Polyline(
        points: points,
        strokeWidth: width,
        color: color,
      );

  ShuttleRoute getDarkRoute(Color darkColor) {
    return ShuttleRoute(
        id: id,
        name: name,
        desc: desc,
        enabled: enabled,
        color: darkColor,
        width: width,
        stopIds: stopIds,
        created: created,
        updated: updated,
        points: points,
        active: active,
        schedules: schedules,
        favorite: favorite
    );
  }

  List get routePoints => points;
  num get strokeWidth => width;
  Color get routeColor => color;
}
