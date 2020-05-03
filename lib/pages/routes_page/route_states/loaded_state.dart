import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../models/shuttle_route.dart';
import '../route_widgets/custom_list_tile.dart';

class LoadedState extends StatefulWidget {
  final List<dynamic> routesJSON;
  final List<dynamic> stopsJSON;
  final ThemeData theme;

  LoadedState({this.routesJSON, this.stopsJSON, this.theme});
  @override
  _LoadedState createState() => _LoadedState();
}

class _LoadedState extends State<LoadedState> {
  List<Widget> _getTileList() {
    var tileList = <CustomListTile>[];
    for (var routeJSON in widget.routesJSON) {
      var route = ShuttleRoute.fromJson(routeJSON);
      tileList.add(CustomListTile(
          route: route, stopsJSON: widget.stopsJSON, theme: widget.theme));
    }
    tileList.sort((a, b) {
      return (a.isEnabled == true && b.isEnabled == false)
          ? -1
          : (a.isEnabled == b.isEnabled) ? 0 : 1;
    });
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _getTileList().length,
        itemBuilder: (context, index) => _getTileList()[index]);
  }
}
