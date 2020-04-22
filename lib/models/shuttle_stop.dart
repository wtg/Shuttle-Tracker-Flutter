import 'shuttle_point.dart';

class ShuttleStop extends ShuttlePoint {
  /// Timestamp of when stop was created
  String created;

  /// Brief description of the stop
  String description;

  /// ID associated with stop
  int id;

  /// Name of the stop
  String name;

  /// Timestamp ofr when stop was updated
  String updated;

  /// Uses a super constructor to define lat/lng attributes
  ShuttleStop(
      {latitude,
      longitude,
      this.name,
      this.created,
      this.updated,
      this.description})
      : super(latitude: 0.0, longitude: 0.0);

  ShuttleStop.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
    description = json['description'];
  }
}
