import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/shuttle_stop.dart';
import 'shuttle_line.dart';

class Panel extends StatefulWidget {
  final ScrollController scrollController;
  final Color routeColor;
  final Map<int, ShuttleStop> routeStops;
  final ThemeData theme;

  Panel(
      {this.scrollController,
      this.routeColor,
      this.routeStops,
      this.theme});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  List<Widget> _getStopTileList(ThemeData theme) {
    var tileList = <Widget>[];
    var i = 0;
    widget.routeStops.forEach((key, value) {
      tileList.add(IntrinsicHeight(
        child: ListTile(
          dense: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ShuttleLine(
                color: widget.routeColor,
                isFirst: i == 0,
                isLast: i == widget.routeStops.length - 1,
              ),
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
          trailing: Icon(
            Platform.isIOS
                ? CupertinoIcons.right_chevron
                : Icons.keyboard_arrow_right,
            color: widget.theme.hoverColor,
          ),
        ),
      ));
      i++;
    });
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    var _stopTileList = _getStopTileList(widget.theme);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //notification listender used to remove scroll glow
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                child: Container(
                  color: widget.routeColor,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Shuttle Stops',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: widget.theme.canvasColor,
                  child: ListView.builder(
                    controller: widget.scrollController,
                    itemCount: _stopTileList.length,
                    itemBuilder: (context, index) => _stopTileList[index],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
