import 'ShuttlePoint.dart';

class ShuttleVehicle extends ShuttlePoint{

  int id;
  String trackerId;
  int heading;
  double speed;
  String time;
  String created;
  int vehicleId;
  int routeId;

  

  ShuttleVehicle(

    latitude, 
    longitude, 
    this.id, 
    this.trackerId,
    this.heading,
    this.speed,
    this.time,
    this.created, 
    this.vehicleId, 
    this.routeId
  ) : super(0.0, 0.0);

  ShuttleVehicle.fromJson(Map<String, dynamic> json) : super.fromJson(json){

    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
    trackerId = json['tracker_id'];
    heading = json['heading'];
    speed = json['speed'];
    time = json['time'];
    created = json['created'];
    vehicleId = json['vehicle_id'];
    routeId = json['route_id'];
  }

}