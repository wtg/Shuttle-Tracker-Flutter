import 'package:flutter/material.dart';

class RoutesSection extends StatefulWidget {
  final ThemeData theme;
  final List<Widget> routes;
  final String sectionHeader;
  RoutesSection({this.theme, this.routes, this.sectionHeader});

  @override
  _RoutesSectionState createState() => _RoutesSectionState();
}

class _RoutesSectionState extends State<RoutesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Text(
            widget.sectionHeader,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.routes.length,
            itemBuilder: (context, index) => widget.routes[index],
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[600],
                height: 4,
              );
            },
          ),
        )
      ],
    );
  }
}
