import 'package:flutter/material.dart';
import '../../../models/shuttle_image.dart';

import 'legend_row.dart';

class Legend extends StatefulWidget {
  final Map<String, ShuttleImage> legend;

  Legend({this.legend});

  @override
  _LegendState createState() => _LegendState();
}

class _LegendState extends State<Legend> {
  @override
  Widget build(BuildContext context) {
    var legendRows = <Widget>[
      LegendRow(
        widget: Image.asset('assets/img/user.png'),
        text: ' You',
      ),
    ];
    widget.legend.forEach((key, value) {
      legendRows.add(LegendRow(
        widget: value.getSVG,
        text: ' $key',
      ));
    });
    legendRows.add(LegendRow(
      widget: Image.asset('assets/img/stop.png'),
      text: ' Shuttle Stop',
    ));
    //print("Number of rows in legend: ${legendRows.length}\n\n");

    return Positioned(
      bottom: 40,
      left: 10,
      child: Opacity(
        opacity: 0.90,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                width: 5,
                color: Theme.of(context).backgroundColor,
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hoverColor,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 0.5))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: legendRows,
          ),
        ),
      ),
    );
  }
}
