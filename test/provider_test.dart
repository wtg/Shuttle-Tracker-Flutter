import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shuttletracker/data/models/shuttle_route.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_stop.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_update.dart';
import 'package:flutter_shuttletracker/data/provider/shuttle_api_provider.dart';

void main() {
  final provider = ShuttleApiProvider();
  group(
    'Provider tests',
    () {
      // Can't test much here except that nothing is null and the types are
      // what they should be, as we don't know how many routes, stops, or
      // updates we'll be receiving from the datafeed, if any, or anything
      // about them

      test('Routes test', () async {
        final routes = await provider.getRoutes();
        expect(routes, isNotNull);
        expect(routes, isA<List>());
        routes.forEach((route) {
          expect(route, isNotNull);
          expect(route, isA<ShuttleRoute>());
        });
      });

      test('Stops test', () async {
        final stops = await provider.getStops();
        expect(stops, isNotNull);
        expect(stops, isA<List>());
        stops.forEach((stop) {
          expect(stop, isNotNull);
          expect(stop, isA<ShuttleStop>());
        });
      });

      test('Updates test', () async {
        final updates = await provider.getUpdates();
        expect(updates, isNotNull);
        expect(updates, isA<List>());
        updates.forEach((update) {
          expect(update, isNotNull);
          expect(update, isA<ShuttleUpdate>());
        });
      });

      test('Connection test', () async {
        // Dummy call to check the connection
        await provider.getRoutes();
        final connected = provider.getIsConnected;
        expect(connected, true);
      });
    },
  );
}
