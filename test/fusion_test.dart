import 'package:flutter_shuttletracker/data/fusion/fusion_socket.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fusion = FusionSocket();
  group(
    'Fusion tests',
    () {
      test('HandleVehicleLocations test', () async {
        var message =
            '''{"type":"vehicle_location","message":{"id":15206204,"tracker_id":"1831394755","latitude":42.7391,"longitude":-73.68313,"heading":83,"speed":2.7340333461761475,"time":"2021-04-15T16:19:20-04:00","created":"2021-04-15T16:27:20.433973-04:00","vehicle_id":2,"route_id":null}} ''';
        final location = await fusion.handleVehicleLocations(message);
        expect(location, isNotNull);
        expect(location, isA<ShuttleUpdate>());
        expect(location.id, 15206204);
        expect(location.trackerId, '1831394755');
        expect(location.latitude, 42.7391);
        expect(location.longitude, -73.68313);
        expect(location.heading, 83);
        expect(location.speed, 2.7340333461761475);
        expect(location.time, DateTime.parse('2021-04-15T16:19:20-04:00'));
        expect(location.created, DateTime.parse('2021-04-15T16:27:20.433973-04:00'));
        expect(location.vehicleId, 2);
        expect(location.routeId, null);
      });
    },
  );
}
