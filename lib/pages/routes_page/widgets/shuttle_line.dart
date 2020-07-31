import 'package:flutter/material.dart';

class ShuttleLine extends StatelessWidget {
  final Color routeColor;
  final bool isSelected;
  ShuttleLine({this.routeColor, this.isSelected});

  @override
  Widget build(BuildContext context) {
    var selectedAsset = ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.green[400], BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop.png',
        width: 20,
        height: 20,
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 9,
          height: 50,
          color: routeColor,
        ),
        Container(
            child: isSelected
                ? selectedAsset
                : Image.asset(
                    'assets/img/stop.png',
                    height: 20,
                    width: 20,
                  )),
        Positioned(
          child: Icon(Icons.keyboard_arrow_down,
              size: 50, color: Theme.of(context).canvasColor),
          top: 23,
        ),
        Positioned(
          child: Icon(Icons.keyboard_arrow_down,
              size: 50, color: Theme.of(context).canvasColor),
          bottom: 27,
        ),
      ],
    );
  }
}
