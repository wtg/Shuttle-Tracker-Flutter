import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../blocs/on_tap_bloc/on_tap_bloc.dart';
import '../blocs/theme_bloc/theme_bloc.dart';
import '../data/models/shuttle_stop.dart';
import 'shuttle_line.dart';

/// Class: Panel Widget
/// Function: Widget that represents a panel on the details page of a route
///           (Holds the stops in order of how they appear on the route)
class Panel extends StatefulWidget {
  final Color routeColor;
  final Map<int, ShuttleStop> routeStops;
  final MapCallback animate;
  final OnTapBloc bloc;

  /// Constructor of the Panel widget
  Panel({this.routeColor, this.routeStops, this.animate, this.bloc});

  @override
  _PanelState createState() => _PanelState();
}

/// Class: _PanelState Widget
/// Function: Widget that represents the state of the Panel widget
class _PanelState extends State<Panel> {
  String selectedName;
  ItemScrollController scrollController = ItemScrollController();

  /// Returns a list of ListTiles that display the shuttle stop name
  List<Widget> _getStopTileList(ThemeData theme) {
    var tileList = <Widget>[];
    var i = 0;
    widget.routeStops.forEach((key, value) {
      var tileSelected = selectedName != null && selectedName == value.name;
      var isDarkTheme = theme.brightness == Brightness.dark;
      var tileTextColor = isDarkTheme ? Colors.white : Colors.black;
      tileList.add(
        IntrinsicHeight(
          child: ListTileTheme(
            selectedColor: tileTextColor,
            child: ListTile(
              dense: true,
              selected: tileSelected ? true : false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ShuttleLine(
                    routeColor: widget.routeColor,
                    isSelected: tileSelected,
                    isStart: (i == 0),
                    isEnd: (i == widget.routeStops.length - 1),
                    isDarkTheme: isDarkTheme,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            value.name,
                            style: TextStyle(
                              color: tileSelected
                                  ? (isDarkTheme
                                      ? Colors.white
                                      : widget.routeColor)
                                  : (isDarkTheme
                                      ? Colors.grey[400]
                                      : Colors.black),
                              fontWeight: tileSelected
                                  ? FontWeight.w900
                                  : FontWeight.w400,
                              fontSize: tileSelected ? 18 : 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                widget.bloc.add(TileStopTapped(stopName: value.name));
                widget.animate(value.getLatLng, 15.2);
              },
            ),
          ),
        ),
      );
      i++;
    });
    return tileList;
  }

  /// Standard function that builds the state of the Panel widget
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //notification listener used to remove scroll glow
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: BlocBuilder<OnTapBloc, OnTapState>(
              bloc: widget.bloc,
              builder: (context, state) {
                if (state is TappedState) {
                  selectedName = state.stopName;
                  if (state.index != null && scrollController.isAttached) {
                    scrollController.scrollTo(
                        index: state.index,
                        duration: Duration(milliseconds: 250));
                  }
                }
                var _stopTileList = _getStopTileList(theme.getTheme);
                return Container(
                  color: theme.getTheme.backgroundColor,
                  child: _stopTileList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.0),
                          child: ScrollablePositionedList.builder(
                            physics: ClampingScrollPhysics(),
                            itemScrollController: scrollController,
                            itemCount: _stopTileList.length,
                            itemBuilder: (context, index) =>
                                _stopTileList[index],
                          ),
                        )
                      : Center(
                          child: Text(
                            'No stops to show',
                          ),
                        ),
                );
              }),
        ),
      );
    });
  }
}

typedef MapCallback = void Function(LatLng pos, double zoom);
