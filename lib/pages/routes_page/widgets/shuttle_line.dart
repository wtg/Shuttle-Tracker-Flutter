import 'package:flutter/material.dart';

/// Class: ShuttleLine
/// Function: A widget that displays a line on the side of the details page that
///           resembles that particular route
class ShuttleLine extends StatelessWidget {
  final Color routeColor;
  final bool isSelected;
  final bool isStart;
  final bool isEnd;
  final bool isDarkTheme;

  /// Constructor for the ShuttleLine widget
  ShuttleLine(
      {this.routeColor,
      this.isSelected,
      this.isStart,
      this.isEnd,
      this.isDarkTheme});

  /// Standard build function that builds that widget
  @override
  Widget build(BuildContext context) {
    var selectedAsset = ColorFiltered(
      colorFilter: ColorFilter.mode(routeColor, BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop_thin.png',
        width: 15,
        height: 15,
      ),
    );

    var stopIcon = ColorFiltered(
      colorFilter: ColorFilter.mode(routeColor, BlendMode.modulate),
      child: Image.asset(
        'assets/img/dark_stop.png',
        width: 15,
        height: 15,
      ),
    );

    var lineHeight = 21.0;
    var lineWidth = 3.0;

    // We have two separate lines, one before the icon, one after
    var topLine = Container(
      margin: EdgeInsets.only(bottom: 35),
      width: lineWidth,
      height: lineHeight,
      color: routeColor,
    );

    var bottomLine = Container(
      margin: EdgeInsets.only(top: 35),
      width: lineWidth,
      height: lineHeight,
      color: routeColor,
    );

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        isStart ? Container() : topLine,
        isEnd ? Container() : bottomLine,
        Container(child: isSelected ? selectedAsset : stopIcon),
      ],
    );
  }
}
