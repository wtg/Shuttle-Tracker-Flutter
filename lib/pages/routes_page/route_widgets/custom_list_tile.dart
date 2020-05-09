import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_shuttletracker/models/shuttle_stop.dart';
import '../../../models/shuttle_image.dart';
import '../../../models/shuttle_route.dart';

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
    return Card(
      elevation: 5.0,
      color: widget.theme.backgroundColor,
      child: ListTile(
        leading: Container(width: 30, height: 25, child: shuttleArrow),
        title: Text(widget.route.name,
            style: TextStyle(color: widget.theme.hoverColor, fontSize: 16)),
        subtitle: Text('${widget.route.enabled ? "ACTIVE" : "INACTIVE"}',
            style: TextStyle(color: widget.theme.hoverColor)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                child: widget.isEnabled && widget.isActive
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
                          )),
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
                //sleep(const Duration(milliseconds: 300));
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
      ),
    );
  }
}
