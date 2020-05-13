import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';

import 'shuttle_image.dart';
import 'shuttle_point.dart';

class ShuttleUpdate extends ShuttlePoint {
  /// ID of the update
  int id;

  /// Not super sure what this is used for
  String trackerId;

  /// Heading in degrees for the shuttle
  num heading;

  /// Speed of the shuttle
  num speed;

  /// Timestamp of when this updated was sent
  String time;

  /// Timestamp of when shuttle was recieved
  String created;

  /// ID associated with the shuttle
  int vehicleId;

  /// The route ID that the shuttle runs on
  int routeId;

  /// The color of the shuttle on the map
  Color color;

  /// The SVG image displayed on the map
  ShuttleImage image;

  /// Uses a super constructor to define lat/lng attributes
  ShuttleUpdate(
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
      : super(latitude: latitude, longitude: longitude);

  Color get getColor => color;

  set setColor(Color color) {
    this.color = color;
    image = ShuttleImage(svgColor: color);
  }

  factory ShuttleUpdate.fromJson(Map<String, dynamic> json) {
    return ShuttleUpdate(
      id: json['id'],
      trackerId: json['tracker_id'],
      heading: (json['heading'] as num).toDouble(),
      speed: json['speed'],
      time: json['time'],
      created: json['created'],
      vehicleId: json['vehicle_id'],
      routeId: json['route_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Marker get getMarker => Marker(
      point: getLatLng,
      width: 30.0,
      height: 30.0,
      builder: (ctx) => RotationTransition(
          turns: AlwaysStoppedAnimation((heading - 45) / 360),
          child: image.getSVG));
}
