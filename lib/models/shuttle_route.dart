import 'dart:core';
import 'dart:ui';

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

  ShuttleRoute({
    this.id,
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
  });

  ShuttleRoute.fromJson(Map<String, dynamic> json) {
    var tempPointsList = json['points'] as List;
    var tempStopList = json['stop_ids'] as List;
    var tempScheduleList = json['schedule'] as List;

    var pointsList =
        tempPointsList.map((i) => ShuttlePoint.fromJson(i).getLatLng).toList();
    var stopIdsList = List<int>.from(tempStopList);
    var schedulesList =
        tempScheduleList.map((i) => ShuttleSchedule.fromJson(i)).toList();

    id = json['id'];
    name = json['name'].toString();
    desc = json['description'].toString();
    enabled = json['enabled'];
    color = Color(int.parse(json['color'].toString().replaceAll('#', '0xff')));
    width = (json['width'] as num).toDouble();
    stopIds = stopIdsList;
    created = json['created'];
    updated = json['updated'];
    points = pointsList;
    active = json['active'];
    schedules = schedulesList;
  }
}
