import 'package:flutter/rendering.dart';

import 'shuttle_image.dart';
import 'shuttle_point.dart';

class ShuttleVehicle extends ShuttlePoint {
  /// The color of the shuttle on the map
  Color color;

  /// Timestamp of when shuttle was recieved
  String created;

  /// Heading in degrees for the shuttle
  num heading;

  /// ID of the update
  int id;

  /// The SVG image displayed on the map
  ShuttleImage image;

  /// The route ID that the shuttle runs on
  int routeId;

  /// Speed of the shuttle
  num speed;

  /// Timestamp of when this updated was sent
  String time;

  /// Not super sure what this is used for
  String trackerId;

  /// ID associated with the shuttle
  int vehicleId;

  /// Uses a super constructor to define lat/lng attributes
  ShuttleVehicle(
      {latitude,
      longitude,
      this.id,
      this.trackerId,
      this.heading,
      this.speed,
      this.time,
      this.created,
      this.vehicleId,
      this.routeId})
      : super(latitude: 0.0, longitude: 0.0);

  ShuttleVehicle.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    trackerId = json['tracker_id'];
    heading = (json['heading'] as num).toDouble();
    speed = json['speed'];
    time = json['time'];
    created = json['created'];
    vehicleId = json['vehicle_id'];
    routeId = json['route_id'];
  }

  Color get getColor => color;

  set setColor(Color color) {
    this.color = color;
    image = ShuttleImage(svgColor: color);
  }
}
