class ShuttleSchedule {
  /// Not sure what this is for
  int id;

  /// ID for the route
  int routeId;

  /// Day of the week route when is enabled (0-6)
  int startDay;

  /// Timestamp when route is enabled on startDay
  String startTime;

  /// Day of the week route when is disabled (0-6)
  int endDay;

  /// Timestamp when route is disabled on endDay
  String endTime;

  ShuttleSchedule(
      {this.id,
      this.routeId,
      this.startDay,
      this.startTime,
      this.endDay,
      this.endTime});

  ShuttleSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    startDay = json['start_day'];
    startTime = json['start_time'];
    endDay = json['end_day'];
    endTime = json['end_time'];
  }
}
