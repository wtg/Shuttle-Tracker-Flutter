import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../models/shuttle_image.dart';
import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';

import '../detail_page.dart';

class CustomListTile extends StatefulWidget {
  final ShuttleRoute route;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  CustomListTile({this.route, this.stops, this.theme});

  bool get isEnabled => route.enabled;
  bool get isActive => route.active;

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    var polyline = <Polyline>[widget.route.getPolyline];
    var ids = widget.route.stopIds;

    var image = ShuttleImage(svgColor: widget.route.color);
    var shuttleArrow = image.getSVG;
    var color = image.getSVGColor;

    var icon = widget.isEnabled && widget.isActive
        ? Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : widget.isEnabled && !widget.isActive
            ? Icon(
                Icons.error,
                color: Colors.yellow[700],
              )
            : Icon(
                Icons.error,
                color: Colors.red,
              );
    return ListTile(
      leading: Container(width: 35, height: 40, child: shuttleArrow),
      title: Text(widget.route.name,
          style: TextStyle(color: widget.theme.hoverColor, fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
              ),
              icon,
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: widget.theme.hoverColor,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          platformPageRoute(
            fullscreenDialog: true,
            context: context,
            builder: (_) {
              return DetailPage(
                title: widget.route.name,
                polyline: polyline,
                shuttleStops: widget.stops,
                ids: ids,
                routeColor: color,
              );
            },
          ),
        );
      },
    );
  }
}
