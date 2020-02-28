import 'package:latlong/latlong.dart';
class ShuttlePoint {
  double latitude;
  double longitude;

  ShuttlePoint(this.latitude, this.longitude);

  ShuttlePoint.fromJson(Map<String, dynamic> json){
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  LatLng convertToLatLng(){
    return LatLng(latitude,longitude);
  }



}