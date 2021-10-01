import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shuttletracker/data/models/shuttle_route.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_point.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_schedule.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_stop.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_eta.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_update.dart';

import 'package:latlong2/latlong.dart';

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

  group(
    'Schedule tests',
    () {
      test('Schedule test', () {
        final json = {
          'id': 4,
          'route_id': 1,
          'start_day': 6,
          'start_time': '0000-01-01T04:00:00-05:00',
          'end_day': 6,
          'end_time': '0000-01-01T17:00:00-05:00'
        };
        final schedule = ShuttleSchedule.fromJson(json);
        expect(schedule.id, 4);
        expect(schedule.routeId, 1);
        expect(schedule.startDay, 6);
        expect(schedule.startTime, '0000-01-01T04:00:00-05:00');
        expect(schedule.endDay, 6);
        expect(schedule.endTime, '0000-01-01T17:00:00-05:00');
      });
    },
  );

  group(
    'Stop tests',
    () {
      test('Union Stop test', () {
        final json = {
          'id': 1,
          'latitude': 42.73029109316892,
          'longitude': -73.67655873298646,
          'name': 'Student Union',
          'created': '2018-09-14T14:06:36.80459-04:00',
          'updated': '2018-09-14T14:06:36.80459-04:00',
          'description': 'Shuttle stop in front of the Student Union'
        };
        final stop = ShuttleStop.fromJson(json);
        expect(stop.id, 1);
        expect(stop.latitude, 42.73029109316892);
        expect(stop.longitude, -73.67655873298646);
        expect(stop.name, 'Student Union');
        expect(stop.created, '2018-09-14T14:06:36.80459-04:00');
        expect(stop.updated, '2018-09-14T14:06:36.80459-04:00');
        expect(stop.description, 'Shuttle stop in front of the Student Union');
      });
    },
  );

  group(
    'ETA tests',
    () {
      test('Past ETA test', () {
        final json = {
          'stop_id': 1,
          'vehicle_id': 2,
          'route_id': 3,
          'eta': '2021-03-25T15:41:47.498879-04:00',
          'arriving': false
        };
        final eta = ShuttleETA.fromJson(json);
        expect(eta.stopId, 1);
        expect(eta.vehicleId, 2);
        expect(eta.routeId, 3);
        expect(eta.eta, DateTime.parse('2021-03-25T15:41:47.498879-04:00'));
        expect(eta.arriving, false);
      });

      test('Future ETA test', () {
        final json = {
          'stop_id': 1,
          'vehicle_id': 2,
          'route_id': 3,
          'eta': '2023-03-25T15:41:47.498879-04:00',
          'arriving': false
        };
        final eta = ShuttleETA.fromJson(json);
        expect(eta.stopId, 1);
        expect(eta.vehicleId, 2);
        expect(eta.routeId, 3);
        expect(eta.eta, DateTime.parse('2023-03-25T15:41:47.498879-04:00'));
        expect(eta.arriving, false);
      });
    },
  );

  group(
    'Update tests',
    () {
      test('Update test', () {
        final json = {
          'id': 15156694,
          'tracker_id': '1831394611',
          'latitude': 42.72733,
          'longitude': -73.68729,
          'heading': 37,
          'speed': 8.76,
          'time': '2021-03-25T15:41:46-04:00',
          'created': '2021-03-25T15:41:47.49-04:00',
          'vehicle_id': 2,
          'route_id': 3
        };
        final update = ShuttleUpdate.fromJson(json);
        expect(update.id, 15156694);
        expect(update.trackerId, '1831394611');
        expect(update.latitude, 42.72733);
        expect(update.longitude, -73.68729);
        expect(update.heading, 37);
        expect(update.speed, 8.76);
        expect(update.time, DateTime.parse('2021-03-25T15:41:46-04:00'));
        expect(update.created, DateTime.parse('2021-03-25T15:41:47.49-04:00'));
        expect(update.vehicleId, 2);
        expect(update.routeId, 3);
      });
    },
  );
}
