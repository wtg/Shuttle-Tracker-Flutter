import 'ShuttlePoint.dart';

class ShuttleStop extends ShuttlePoint{

  String name;
  String created;
  String updated;
  String description;
  

  ShuttleStop(

    latitude, 
    longitude, 
    this.name, 
    this.created, 
    this.updated, 
    this.description
  ) : super(0.0, 0.0);

  ShuttleStop.fromJson(Map<String, dynamic> json) : super.fromJson(json){

    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
    description = json['description'];
  }

  
}