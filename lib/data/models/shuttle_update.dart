import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../global_widgets/shuttle.dart';
import '../../global_widgets/shuttle_svg.dart';
import 'shuttle_point.dart';

class ShuttleUpdate extends ShuttlePoint {
  /// ID of the update
  final int id;

  /// Not super sure what this is used for
  final String trackerId;

  /// Heading in degrees for the shuttle
  final num heading;

  /// Speed of the shuttle
  final num speed;

  /// Timestamp of when this updated was sent
  final DateTime time;

  /// Timestamp of when shuttle was recieved
  final DateTime created;

  /// ID associated with the shuttle
  final int vehicleId;

  /// The route ID that the shuttle runs on
  final int routeId;

  /// The color of the shuttle on the map
  Color color;

  /// The SVG arrow displayed on the map
  ShuttleSVG svg;

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
    svg = ShuttleSVG(svgColor: color);
  }

  factory ShuttleUpdate.fromJson(Map<String, dynamic> json) {
    return ShuttleUpdate(
      id: json['id'],
      trackerId: json['tracker_id'],
      heading: (json['heading'] as num).toDouble(),
      speed: json['speed'],
      time: DateTime.parse(json['time']),
      created: DateTime.parse(json['created']),
      vehicleId: json['vehicle_id'],
      routeId: json['route_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Marker getMarker(dynamic animatedMapMove, [BuildContext context]) {
    return Marker(
        point: getLatLng,
        width: 30.0,
        height: 30.0,
        builder: (ctx) {
          return Shuttle(
            animatedMapMove: animatedMapMove,
            context: context,
            svg: svg,
            heading: heading,
            vehicleId: vehicleId,
            getLatLng: getLatLng,
          );
        });
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$trackerId $latitude $longitude $heading $speed $time $created $vehicleId $routeId";
  }
}
