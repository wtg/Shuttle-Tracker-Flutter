import 'package:latlong/latlong.dart';

class ShuttlePoint {
  double latitude;
  double longitude;

  LatLng get getLatLng => LatLng(latitude, longitude);

  ShuttlePoint({this.latitude, this.longitude});

  ShuttlePoint.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
