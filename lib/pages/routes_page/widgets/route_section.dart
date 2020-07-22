import 'package:flutter/material.dart';

class RoutesSection extends StatelessWidget {
  final ThemeData theme;
  final List<Widget> routes;
  final String sectionHeader;
  RoutesSection({this.theme, this.routes, this.sectionHeader});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Text(
            sectionHeader,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
            itemCount: routes.length,
            itemBuilder: (context, index) => routes[index],
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[600],
                height: 4,
                thickness: 0,
                indent: 57,
              );
            },
          ),
        )
      ],
    );
  }
}
