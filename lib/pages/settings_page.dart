import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/models/shuttle_image.dart';
import 'package:flutter_shuttletracker/models/shuttle_route.dart';

import '../blocs/theme/theme_bloc.dart';
import '../blocs/shuttle/shuttle_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ShuttleBloc shuttleBloc;
  bool isSwitched = false;
  Map<String, ShuttleImage> mapkey = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme) {
        List<Widget> tile_list = [
          ListTile(
              leading: Icon(
                Icons.settings_brightness,
                color: theme.hoverColor,
              ),
              title: Text('Dark Mode',
                  style: TextStyle(color: theme.hoverColor, fontSize: 15)),
              trailing: PlatformSwitch(
                value: isSwitched,
                onChanged: (value) {
                  isSwitched = value;
                  context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                },
                activeColor: Colors.red,
                android: (_) =>
                    MaterialSwitchData(activeTrackColor: Colors.grey),
              )),
        ];
        return Center(child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
          if (state is ShuttleInitial) {
            shuttleBloc.add(GetSettingsList());
          } else if (state is ShuttleLoaded) {
            var routesJSON = state.routes;

            for (var routeJSON in routesJSON) {
              var route = ShuttleRoute.fromJson(routeJSON);
              var shuttleArrow = ShuttleImage(svgColor: route.color);
              tile_list.add(ListTile(
                  leading: Container(
                      width: 30, height: 25, child: shuttleArrow.getSVG),
                  title: Text(route.name,
                      style: TextStyle(color: theme.hoverColor, fontSize: 15)),
                  trailing: PlatformSwitch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = value;
                      context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                    },
                    activeColor: Colors.red,
                    android: (_) =>
                        MaterialSwitchData(activeTrackColor: Colors.grey),
                  )));
            }
            ListView.builder(
                itemCount: tile_list.length,
                itemBuilder: (context, index) {
                  return tile_list[index];
                });
          }
          return ListView.builder(
              itemCount: tile_list.length,
              itemBuilder: (context, index) {
                return tile_list[index];
              });
        }));
      },
    ));
  }
}
