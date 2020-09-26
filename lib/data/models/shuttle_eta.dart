class ShuttleETA {
  final int stopId;
  final int vehicleId;
  final int routeId;
  final DateTime eta;
  final bool arriving;

  ShuttleETA(
      {this.stopId, this.vehicleId, this.routeId, this.eta, this.arriving});

  factory ShuttleETA.fromJson(Map<String, dynamic> json) {
  	return ShuttleETA(
			stopId: json['stopId']
		)
	}
}
