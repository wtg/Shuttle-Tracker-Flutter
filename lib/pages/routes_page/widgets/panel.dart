import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../models/shuttle_stop.dart';
import 'shuttle_line.dart';

class Panel extends StatefulWidget {
  final Color routeColor;
  final Map<int, ShuttleStop> routeStops;
  final MapCallback animate;
  final MarkerCallback changeMarker;
  Panel({this.routeColor, this.routeStops, this.animate, this.changeMarker});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  ShuttleStop selected;

  List<Widget> _getStopTileList(ThemeData theme) {
    var tileList = <Widget>[];
    widget.routeStops.forEach((key, value) {
      tileList.add(
        IntrinsicHeight(
          child: ListTileTheme(
            selectedColor: Colors.green[600],
            child: ListTile(
              dense: true,
              selected: selected != null && selected.name == value.name
                  ? true
                  : false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ShuttleLine(color: widget.routeColor),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: selected != null && selected.name == value.name
                              ? Colors.green.withOpacity(0.1)
                              : theme.backgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          shape: BoxShape.rectangle),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  selected = value;
                });
                widget.animate(value.getLatLng, 15.2);
                widget.changeMarker(widget.routeStops, value);
              },
            ),
          ),
        ),
      );
    });
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      var _stopTileList = _getStopTileList(theme.getTheme);
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //notification listener used to remove scroll glow
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: theme.getTheme.backgroundColor,
                  child: _stopTileList.length != 0
                      ? ListView.builder(
                          itemCount: _stopTileList.length,
                          itemBuilder: (context, index) => _stopTileList[index],
                        )
                      : Center(
                          child: Text(
                            'No stops to show',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

typedef MapCallback = void Function(LatLng pos, double zoom);
typedef MarkerCallback = void Function(Map<int, ShuttleStop> shuttleStops,
    [ShuttleStop stop]);
