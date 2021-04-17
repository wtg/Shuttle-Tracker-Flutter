import 'package:flutter_shuttletracker/data/fusion/fusion_socket.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_eta.dart';
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
        expect(location.created,
            DateTime.parse('2021-04-15T16:27:20.433973-04:00'));
        expect(location.vehicleId, 2);
        expect(location.routeId, null);
      });

      test('HandleETA test', () async {
        var message =
            '''{"type":"eta","message":{"stop_etas" : [{"stop_id": 12345, "eta": "2021-04-15T16:19:20-04:00", "arriving": true}], "vehicle_id": 12345, "route_id": 12345}} ''';
        final etas = fusion.handleEtas(message);
        expect(etas, isNotNull);
        expect(etas, isA<List<ShuttleETA>>());
        etas.forEach((eta) {
          expect(eta, isNotNull);
          expect(eta, isA<ShuttleETA>());
          expect(eta.stopId, 12345);
          expect(eta.eta, DateTime.parse('2021-04-15T16:19:20-04:00'));
          expect(eta.arriving, true);
          expect(eta.routeId, 12345);
          expect(eta.vehicleId, 12345);
          
        });
      });

      // test('Routes test', () async {
      //   final routes = await provider.getRoutes();
      //   expect(routes, isNotNull);
      //   expect(routes, isA<List>());
      //   routes.forEach((route) {
      //     expect(route, isNotNull);
      //     expect(route, isA<ShuttleRoute>());
      //   });
      // });
    },
  );
}
