import 'package:flutter/material.dart';


class FavoritesSection extends StatefulWidget {
  final ThemeData theme;
  final List<Widget> routes;
  final String sectionHeader;
  FavoritesSection({this.theme, this.routes, this.sectionHeader});

  @override
  _FavoritesSectionState createState() => _FavoritesSectionState();
}

class _FavoritesSectionState extends State<FavoritesSection> {
  @override
  Widget build(BuildContext context) {
    if(widget.routes.length == 0){
      return Column();
    }
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Text(
            widget.sectionHeader,
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
            itemCount: widget.routes.length,
            itemBuilder: (context, index) => widget.routes[index],
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[600],
                height: 4,
                thickness: 0,
                indent: 55.0,
              );
            },
          ),
        )
      ],
    );
  }
}
