import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shuttletracker/models/shuttle_stop.dart';
import '../../../models/shuttle_route.dart';
import '../route_widgets/custom_list_tile.dart';

class LoadedState extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  LoadedState({this.routes, this.stops, this.theme});
  @override
  _LoadedState createState() => _LoadedState();
}

class _LoadedState extends State<LoadedState> {
  List<Widget> _getTileList() {
    var tileList = <CustomListTile>[];
    for (var route in widget.routes) {
      tileList.add(CustomListTile(
          route: route, stops: widget.stops, theme: widget.theme));
    }
    tileList.sort((a, b) {
      return ((a.isEnabled == true && a.isActive == true) &&
              ((b.isEnabled == true ?? b.isActive == false) ||
                  (b.isEnabled == false ?? b.isActive == true) ||
                  (b.isEnabled == false ?? b.isActive == false)))
          ? -1
          : (a.isEnabled == b.isEnabled && a.isActive == b.isActive) ? 0 : 1;
    });
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    var tileList = _getTileList();
    //notification listender used to remove scroll glow

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return null;
      },
      child: Container(
        color: widget.theme.bottomAppBarColor,
        child: ListView.builder(
            itemCount: tileList.length,
            itemBuilder: (context, index) => tileList[index]),
      ),
    );
  }
}
