import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class ShuttlePoint extends Equatable {
  final double latitude;
  final double longitude;

  LatLng get getLatLng => LatLng(latitude, longitude);

  ShuttlePoint({this.latitude, this.longitude});

  factory ShuttlePoint.fromJson(Map<String, dynamic> json) {
    return ShuttlePoint(
        latitude: json['latitude'], longitude: json['longitude']);
  }

  @override
  List<Object> get props => [latitude, longitude];
}
