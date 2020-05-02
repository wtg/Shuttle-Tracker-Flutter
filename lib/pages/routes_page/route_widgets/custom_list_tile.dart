import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../models/shuttle_image.dart';
import '../../../models/shuttle_route.dart';

import '../detail_page.dart';

class CustomListTile extends StatefulWidget {
  final ShuttleRoute route;
  final List<dynamic> stopsJSON;
  final ThemeData theme;

  CustomListTile({this.route, this.stopsJSON, this.theme});
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
    return Card(
      color: widget.theme.backgroundColor,
      child: ListTile(
        leading: Container(width: 30, height: 25, child: shuttleArrow),
        title: Text(widget.route.name,
            style: TextStyle(color: widget.theme.hoverColor, fontSize: 16)),
        subtitle: Text(
            'This route is ${widget.route.active ? "ACTIVE" : "INACTIVE"} this semester',
            style: TextStyle(color: widget.theme.hoverColor)),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: widget.theme.hoverColor,
        ),
        onTap: () {
          Navigator.push(
            context,
            platformPageRoute(
              context: context,
              builder: (_) => DetailPage(
                title: widget.route.name,
                polyline: polyline,
                stops: widget.stopsJSON,
                ids: ids,
                color: color,
              ),
            ),
          );
        },
      ),
    );
  }
}
