import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';
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
      return (a.isEnabled == true && b.isEnabled == false)
          ? -1
          : (a.isEnabled == b.isEnabled) ? 0 : 1;
    });
    return tileList;
  }

  @override
  Widget build(BuildContext context) {
    //notification listender used to remove scroll glow
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return null;
        },
        child: Container(
          color: theme.getTheme.bottomAppBarColor,
          child: ListView.builder(
              itemCount: _getTileList().length,
              itemBuilder: (context, index) => _getTileList()[index]),
        ),
      );
    });
  }
}
