import 'ShuttlePoint.dart';
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
  bool active;

  List<LatLng> points;

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
  );

  ShuttleRoute.fromJson(Map<String, dynamic> json) {
    var list = json['points'] as List;
   
    List<LatLng> pointsList = list.map((i) => ShuttlePoint.fromJson(i).convertToLatLng()).toList();
    
    id = json['id'];
    name = json['name'].toString();
    desc = json['description'].toString();
    enabled = json['enabled'];
    color = Color(int.parse(json['color'].toString().replaceAll('#', '0xff')));
    width = json['width'];
    width = width.toDouble();
    //stopIds = json['stop_ids'];
    created = json['created'];
    updated = json['updated'];
    points = pointsList;
    
    
  }
}