import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../global_widgets/shuttle_arrow.dart';
import 'legend_row.dart';

class Legend extends StatelessWidget {
  final Map<String, ShuttleArrow> legend;

  Legend({this.legend});

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
        bottom: 15,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
              color: theme.getTheme.backgroundColor,
              border: Border.all(
                width: 5,
                color: theme.getTheme.backgroundColor,
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: theme.getThemeState
                  ? null
                  : [
                      BoxShadow(
                          color: Colors.grey, // Changed from black
                          blurRadius: 1.0,
                          offset: Offset(0.0, 0.5))
                    ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendRows,
          ),
        ),
      );
    });
  }
}
