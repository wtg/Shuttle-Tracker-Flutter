class ShuttleSchedule {
  int id;
  int routeId;
  int startDay;
  DateTime startTime;
  int endDay;
  DateTime endTime;

  ShuttleSchedule(this.id, this.routeId, this.startDay, this.startTime,
      this.endDay, this.endTime);

  ShuttleSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    startDay = json['start_day'];
    //startTime = json['start_time'];
    endDay = json['end_day'];
    //endTime = json['end_time'];
  }
}
