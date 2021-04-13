import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

import 'package:flutter_shuttletracker/theme/helpers.dart';

void main() {
  group(
    'Helper tests',
    () {
      test('Luma test', () {
        final lightColor = shadeColor(Color(int.parse('0xff0000ff')), 0.35);
        final darkColor = shadeColor(Color(int.parse('0xff0000ff')), 0.70);
        // Coefficients from Rec. 709
        final lightLuma = 0.2126 * lightColor.red +
            0.7152 * lightColor.green +
            0.0722 * lightColor.blue;
        final darkLuma = 0.2126 * darkColor.red +
            0.7152 * darkColor.green +
            0.0722 * darkColor.blue;
        expect(darkLuma, lessThan(lightLuma));
      });
    },
  );
}
