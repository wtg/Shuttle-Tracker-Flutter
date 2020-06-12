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

  Panel({this.routeColor, this.routeStops, this.animate});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  List<Widget> _getStopTileList(ThemeData theme) {
    var tileList = <Widget>[];
    widget.routeStops.forEach((key, value) {
      tileList.add(
        IntrinsicHeight(
          child: ListTile(
            dense: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ShuttleLine(color: widget.routeColor),
                SizedBox(
                  width: 30,
                ),
                Center(
                  child: Text(
                    value.name,
                    style: theme.textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            onTap: () {
              widget.animate(value.getLatLng, 14.2);
            },
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: theme.getTheme.canvasColor,
                      child: ListView.separated(
//                      controller: widget.scrollController,
                        itemCount: _stopTileList.length,
                        itemBuilder: (context, index) => _stopTileList[index],
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey[600],
                            indent: 50.0,
                            height: 3,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

typedef MapCallback = void Function(LatLng pos, double zoom);