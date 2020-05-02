import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_shuttletracker/blocs/shuttle/shuttle_bloc.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';
import 'package:flutter_shuttletracker/models/shuttle_image.dart';
import 'package:flutter_shuttletracker/models/shuttle_route.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'detail_page.dart';

class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  ShuttleBloc shuttleBloc;
  bool isSwitched = false;
  Map<String, ShuttleImage> mapkey = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme) {
        var tileList = [];

        return Center(child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
          if (state is ShuttleInitial || state is ShuttleError) {
            shuttleBloc.add(ShuttleEvent.getSettingsList);
          } else if (state is ShuttleLoaded) {
            var routesJSON = state.routes;
            var stopsJSON = state.stops;

            for (var routeJSON in routesJSON) {
              var route = ShuttleRoute.fromJson(routeJSON);
              var image = ShuttleImage(svgColor: route.color);
              var shuttleArrow = image.getSVG;
              var color = image.getSVGColor;

              var ids = route.stopIds;
              var polyline = <Polyline>[];
              polyline.add(route.getPolyline);

              tileList.add(Card(
                color: theme.backgroundColor,
                child: ListTile(
                  leading:
                      Container(width: 30, height: 25, child: shuttleArrow),
                  title: Text(route.name,
                      style: TextStyle(color: theme.hoverColor, fontSize: 16)),
                  subtitle: Text(
                      'This route is ${route.active ? "ACTIVE" : "INACTIVE"} this semester',
                      style: TextStyle(color: theme.hoverColor)),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: theme.hoverColor,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      platformPageRoute(
                        context: context,
                        builder: (_) => DetailPage(
                          title: route.name,
                          polyline: polyline,
                          stops: stopsJSON,
                          ids: ids,
                          color: color,
                        ),
                      ),
                    );
                  },
                ),
              ));
            }
            ListView.builder(
                itemCount: tileList.length,
                itemBuilder: (context, index) => tileList[index]);
          }
          return ListView.builder(
              itemCount: tileList.length,
              itemBuilder: (context, index) => tileList[index]);
        }));
      },
    ));
  }
}
