import 'package:flutter/material.dart';

class ShuttleLine extends StatelessWidget {
  final Color routeColor;
  final bool isSelected;
  final bool isStart;
  final bool isEnd;
  final bool isDarkTheme;
  ShuttleLine(
      {this.routeColor,
      this.isSelected,
      this.isStart,
      this.isEnd,
      this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    var selectedAsset = ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.green[400], BlendMode.modulate),
      child: Image.asset(
        isDarkTheme ? 'assets/img/dark_stop.png' : 'assets/img/stop.png',
        width: 20,
        height: 20,
      ),
    );

    // We can probably do this a little cleaner
    var line = Container(
      width: 5,
      height: 50,
      color: routeColor,
    );

    if (isStart) {
      line = Container(
        margin: EdgeInsets.only(top: 24),
        width: 5,
        height: 25,
        color: routeColor,
      );
    }

    if (isEnd) {
      line = Container(
        margin: EdgeInsets.only(bottom: 24),
        width: 5,
        height: 25,
        color: routeColor,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        line,
        Container(
          child: isSelected
              ? selectedAsset
              : Image.asset(
                  isDarkTheme ? 'assets/img/dark_stop.png' : 'assets/img/stop.png',
                  height: 20,
                  width: 20,
                ),
        ),
        //
      ],
    );
  }
}
