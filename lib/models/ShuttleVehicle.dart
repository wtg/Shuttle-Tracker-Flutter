import 'package:flutter/rendering.dart';
import 'ShuttleImage.dart';
import 'ShuttlePoint.dart';

class ShuttleVehicle extends ShuttlePoint {
  int id;
  String trackerId;
  num heading;
  num speed;
  String time;
  String created;
  int vehicleId;
  int routeId;
  Color color;
  ShuttleImage image;

  ShuttleVehicle(latitude, longitude, this.id, this.trackerId, this.heading,
      this.speed, this.time, this.created, this.vehicleId, this.routeId)
      : super(0.0, 0.0);

  set setImage(Color color) {
    this.color = color;
    image = ShuttleImage(svgColor: color);
  }

  ShuttleVehicle.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    trackerId = json['tracker_id'];
    heading = json['heading'];
    heading = heading.toDouble();
    speed = json['speed'];
    time = json['time'];
    created = json['created'];
    vehicleId = json['vehicle_id'];
    routeId = json['route_id'];
  }
}
