import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shuttletracker/data/models/shuttle_route.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_point.dart';

import 'package:latlong/latlong.dart';

void main() {
  group(
    'Route tests',
    () {
      test('West Campus route test', () {
        final json = {
          'id': 1,
          'name': 'West Campus',
          'description': 'Shuttle route for West Campus',
          'enabled': true,
          'color': '#ff0000',
          'width': 10.0,
          'stop_ids': [1, 2, 3],
          'created': '2018-09-14T13:04:49.250185-04:00',
          'updated': '2019-11-04T11:04:22.731589-05:00',
          'points': [], // Route point tested separately
          'active': true,
          'schedule': [] // Shuttle schedule tested separately
        };
        final route = ShuttleRoute.fromJson(json);
        expect(route.id, 1);
        expect(route.name, 'West Campus');
        expect(route.desc, 'Shuttle route for West Campus');
        expect(route.enabled, true);
        expect(route.color, Color(int.parse('0xffff0000')));
        expect(route.width, 7.0);
        expect(route.stopIds, [1, 2, 3]);
        expect(route.created, '2018-09-14T13:04:49.250185-04:00');
        expect(route.updated, '2019-11-04T11:04:22.731589-05:00');
        expect(route.points, []);
        expect(route.active, true);
        expect(route.schedules, []);
      });

      final route = ShuttleRoute(
          id: 1,
          name: 'West Campus',
          desc: 'Shuttle route for West Campus',
          enabled: true,
          color: Color(int.parse('0xffff0000')),
          width: 10.0,
          stopIds: [1, 2, 3],
          created: '2018-09-14T13:04:49.250185-04:00',
          updated: '2019-11-04T11:04:22.731589-05:00',
          points: [
            LatLng(42.7307, -73.67659),
            LatLng(42.7307, -73.67657),
            LatLng(42.73047, -73.67663)
          ],
          active: true,
          schedules: [],
          favorite: false);

      test('Dark route test', () {
        final darkRoute = route.getDarkRoute();
        expect(darkRoute.color, Color(int.parse('0xffa60000')));
      });

      test('Polyline test', () {
        final polyline = route.getPolyline;
        expect(polyline.points, route.points);
        expect(polyline.strokeWidth, route.width);
        expect(polyline.color, route.color);
      });

      test('Dark polyline test', () {
        final polyline = route.getDarkPolyline;
        expect(polyline.color, route.getDarkRoute().color);
      });
    },
  );

  group(
    'Point tests',
    () {
      test('Union test', () {
        final json = {
          'latitude': 42.73029109316892,
          'longitude': -73.67655873298646
        };
        final point = ShuttlePoint.fromJson(json);
        expect(point.latitude, 42.73029109316892);
        expect(point.longitude, -73.67655873298646);
      });
    },
  );
}
