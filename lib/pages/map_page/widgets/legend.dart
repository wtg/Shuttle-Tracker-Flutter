import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../global_widgets/shuttle_svg.dart';
import 'legend_row.dart';

/// Class: Legend Widget
/// Function: Creates an instance of the Legend widget, an example can be seen
///           in the corner of the map page on the application
class Legend extends StatelessWidget {
  final Map<String, ShuttleSVG> legend;

  Legend({this.legend});

  /// Standard build function
  @override
  Widget build(BuildContext context) {
    var legendRows = <Widget>[
      LegendRow(
        widget: Image.asset('assets/img/user.png'),
        text: ' You',
      ),
    ];
    legend.forEach((key, value) {
      legendRows.add(LegendRow(
        widget: value,
        text: ' $key',
      ));
    });
    legendRows.add(LegendRow(
      widget: Image.asset('assets/img/stop.png'),
      text: ' Shuttle Stop',
    ));
    //print("Number of rows in legend: ${legendRows.length}\n\n");
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Positioned(
        // Position of widget at bottom left corner
        bottom: 15,
        left: 10,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              color: theme.getTheme.backgroundColor,
              border: Border.all(
                width: 5,
                color: theme.getTheme.backgroundColor,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: theme.getThemeState
                  ? null
                  : [
                      BoxShadow(
                          color: Colors.grey, // Changed from black
                          blurRadius: 1.0,
                          offset: Offset(0.0, 0.5))
                    ]),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: legendRows,
            ),
          ),
        ),
      );
    });
  }
}
