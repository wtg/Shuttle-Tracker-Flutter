import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../blocs/theme/theme_bloc.dart';

class SchedulesPage extends StatefulWidget {
  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return PlatformScaffold(
          appBar: PlatformAppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Schedules',
                style: TextStyle(
                  color: theme.getTheme.hoverColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            backgroundColor: theme.getTheme.bottomAppBarColor,
          ),
          backgroundColor: theme.getTheme.bottomAppBarColor,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: theme.getTheme.hoverColor,
                    color: theme.getTheme.backgroundColor,
                    elevation: theme.getThemeState ? 0 : 2,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text('Weekday Routes',
                              style: TextStyle(
                                  color: theme.getTheme.hoverColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19)),
                          Text(
                              '\nNorth, South, and New West Routes\n'
                                  'Monday–Friday 7am – 11pm\n',
                              style: TextStyle(
                                  color: theme.getTheme.hoverColor,
                                  fontSize: 13)),
                          Text('View PDF',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: theme.getTheme.hoverColor,
                    color: theme.getTheme.backgroundColor,
                    elevation: theme.getThemeState ? 0 : 2,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text('Weekend Routes\n',
                              style: TextStyle(
                                  color: theme.getTheme.hoverColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19)),
                          Text(
                              'West and East Routes\n'
                                  'Saturday–Sunday 9:30am – 5pm\n\n'
                                  'Weekend Express Route\n'
                                  'Saturday–Sunday 4:30pm – 8pm\n\n'
                                  'Late Night Route\n'
                                  'Friday–Saturday 8pm – 4am\n',
                              style: TextStyle(
                                  color: theme.getTheme.hoverColor,
                                  fontSize: 13)),
                          Text('View PDF',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
