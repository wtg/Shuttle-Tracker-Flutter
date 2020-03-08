import 'ShuttlePoint.dart';
import 'ShuttleSchedule.dart';
import 'package:latlong/latlong.dart';
import 'dart:core';
import 'dart:ui';

class ShuttleRoute {
  int id;
  String name;
  String desc;
  bool enabled;
  Color color;
  num width;
  List<int> stopIds;
  String created;
  String updated;
  List<LatLng> points;
  bool active;
  List<ShuttleSchedule> schedule;

  ShuttleRoute(
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
    this.schedule,
  );

  ShuttleRoute.fromJson(Map<String, dynamic> json) {
    var tempPointsList = json['points'] as List;
    var tempStopsList = json['stop_ids'] as List;
    var tempScheduleList = json['schedule'] as List;

    List<LatLng> pointsList = tempPointsList
        .map((i) => ShuttlePoint.fromJson(i).convertToLatLng())
        .toList();
    List<int> stopIdsList = List<int>.from(tempStopsList);
    List<ShuttleSchedule> scheduleList =
        tempScheduleList.map((i) => ShuttleSchedule.fromJson(i)).toList();

    id = json['id'];
    name = json['name'].toString();
    desc = json['description'].toString();
    enabled = json['enabled'];
    color = Color(int.parse(json['color'].toString().replaceAll('#', '0xff')));
    width = json['width'];
    width = width.toDouble();
    stopIds = stopIdsList;
    created = json['created'];
    updated = json['updated'];
    points = pointsList;
    active = json['active'];
    schedule = scheduleList;
  }
}
