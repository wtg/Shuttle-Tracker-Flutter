import 'dart:core';
import 'dart:ui';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'shuttle_point.dart';
import 'shuttle_schedule.dart';

class ShuttleRoute {
  /// Id for this route
  int id;

  /// Name of this route
  String name;

  /// Description of this route
  String desc;

  /// Bool to determine if route is enabled for semester
  bool enabled;

  /// Hex color of route
  Color color;

  /// Width of route outline on map
  num width;

  /// All stop ids associated with route
  List<int> stopIds;

  /// Timestamp for when route was created
  String created;

  /// Timestamp for when route was last updated
  String updated;

  /// All points required to create the route with respective lat/lng values
  List<LatLng> points;

  /// Bool to determine if route is active at current period of time
  bool active;

  /// List of shuttles currently associated with this route
  List<ShuttleSchedule> schedules;

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
      this.schedules});

  factory ShuttleRoute.fromJson(Map<String, dynamic> json) {
    return ShuttleRoute(
      id: json['id'],
      name: json['name'].toString(),
      desc: json['description'].toString(),
      enabled: json['enabled'],
      color: Color(int.parse(json['color'].toString().replaceAll('#', '0xff'))),
      width: (json['width'] as num).toDouble(),
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
    );
  }

  Polyline get getPolyline => Polyline(
        points: points,
        strokeWidth: width,
        color: color,
      );
}
