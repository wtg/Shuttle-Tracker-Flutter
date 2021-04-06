import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shuttletracker/data/models/shuttle_route.dart';
import 'package:flutter_shuttletracker/data/repository/shuttle_repository.dart';
import 'package:flutter_shuttletracker/global_widgets/shuttle_svg.dart';
import 'package:flutter_shuttletracker/theme/helpers.dart';

void main() {
  final repository = ShuttleRepository();
  group(
    'Repository tests',
    () {
      test('Routes test', () async {
        // More rigorous testing occurs in the provider tests
        final routes = repository.getRoutes;
        expect(routes, isNotNull);
        expect(routes, isA<List>());
      });

      test('Stops test', () async {
        // More rigorous testing occurs in the provider tests
        final stops = repository.getStops;
        expect(stops, isNotNull);
        expect(stops, isA<List>());
      });

      test('Updates test', () async {
        // More rigorous testing occurs in the provider tests
        final updates = repository.getRoutes;
        expect(updates, isNotNull);
        expect(updates, isA<List>());
      });

      test('Dark routes test', () async {
        final darkRoutes = await repository.getDarkRoutes();
        final lightRoutes = await repository.getRoutes;
        expect(darkRoutes, isNotNull);
        expect(darkRoutes, isA<List>());
        darkRoutes.forEach((darkRoute) {
          expect(darkRoute, isNotNull);
          expect(darkRoute, isA<ShuttleRoute>());
          // Find corresponding light route for color comparison
          var lightRouteColor;
          for (final lightRoute in lightRoutes) {
            if (lightRoute.name == darkRoute.name) {
              lightRouteColor = lightRoute.color;
            }
          }
          expect(darkRoute.color, shadeColor(lightRouteColor, 0.35));
        });
      });

      test('Auxiliary data test', () async {
        final data = await repository.getAuxiliaryRouteData();

        // Can't test much here except that nothing is null and all types are
        // what they should be, as we don't know how much route data we will
        // receive, if any

        expect(data.ids, isNotNull);
        expect(data.ids, isA<List>());
        data.ids.forEach((id) {
          expect(id, isNotNull);
          expect(id, isA<int>());
        });

        expect(data.legend, isNotNull);
        data.legend.forEach((routeName, svg) {
          expect(routeName, isNotNull);
          expect(routeName, isA<String>());
          expect(svg, isNotNull);
          expect(svg, isA<ShuttleSVG>());
        });

        expect(data.colors, isNotNull);
        data.colors.forEach((id, color) {
          expect(id, isNotNull);
          expect(id, isA<int>());
          expect(color, isNotNull);
          expect(color, isA<Color>());
        });

        expect(data.darkLegend, isNotNull);
        data.darkLegend.forEach((routeName, svg) {
          expect(routeName, isNotNull);
          expect(routeName, isA<String>());
          expect(svg, isNotNull);
          expect(svg, isA<ShuttleSVG>());
          expect(
              svg.svgColor, shadeColor(data.legend[routeName].svgColor, 0.35));
        });
      });
    },
  );
}
