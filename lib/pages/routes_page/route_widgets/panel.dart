import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';
import 'package:flutter_shuttletracker/models/shuttle_stop.dart';

class Panel extends StatefulWidget {
  final ScrollController scrollController;
  final Color routeColor;
  final List<ShuttleStop> routeStops;
  final List<int> ids;

  Panel({this.scrollController, this.routeColor, this.routeStops, this.ids});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  List<Widget> _getStopTileList(ThemeData theme) {
    var tileList = <Card>[];
    for (var shuttleStop in widget.routeStops) {
      tileList.add(Card(
          color: theme.backgroundColor,
          child: ListTile(
              leading: Text(
            shuttleStop.name,
            style: theme.textTheme.bodyText1,
          ))));
    }
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, theme) {
      var _stopTileList = _getStopTileList(theme);
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
                              "Shuttle Stops",
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
                    color: theme.appBarTheme.color,
                    child: ListView.builder(
                        controller: widget.scrollController,
                        itemCount: _stopTileList.length,
                        itemBuilder: (context, index) => _stopTileList[index]),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
