import 'ShuttlePoint.dart';

class ShuttleStop extends ShuttlePoint {
  int id;
  String name;
  String created;
  String updated;
  String description;

  ShuttleStop(latitude, longitude, this.name, this.created, this.updated,
      this.description)
      : super(0.0, 0.0);

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
