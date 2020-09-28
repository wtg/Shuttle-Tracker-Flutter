class ShuttleSchedule {
  /// Not sure what this is for
  final int id;

  /// ID for the route
  final int routeId;

  /// Day of the week route when is enabled (0-6)
  final int startDay;

  /// Timestamp when route is enabled on startDay
  final String startTime;

  /// Day of the week route when is disabled (0-6)
  final int endDay;

  /// Timestamp when route is disabled on endDay
  final String endTime;

  ShuttleSchedule(
      {this.id,
      this.routeId,
      this.startDay,
      this.startTime,
      this.endDay,
      this.endTime});

  factory ShuttleSchedule.fromJson(Map<String, dynamic> json) {
    return ShuttleSchedule(
      id: json['id'],
      routeId: json['route_id'],
      startDay: json['start_day'],
      startTime: json['start_time'],
      endDay: json['end_day'],
      endTime: json['end_time'],
    );
  }
}
