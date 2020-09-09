import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme/theme_bloc.dart';

class SchedulesPage extends StatefulWidget {
  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Schedules',
              style: TextStyle(
                color: theme.getTheme.hoverColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: theme.getTheme.bottomAppBarColor,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: Container(
              color: theme.getTheme.backgroundColor,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: theme.getTheme.hoverColor,
                      color: theme.getTheme.cardColor,
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
                            Text(''' 

North and West Routes
Monday–Friday 7am – 11:45pm

Hudson Valley College Suites Shuttles
Monday – Friday 7am – 7pm

CDTA Express Route
Monday–Friday 7am – 7pm
                                ''',
                                style: TextStyle(
                                    color: theme.getTheme.hoverColor,
                                    fontSize: 13)),
                            // GestureDetector(
                            //   onTap: () async {
                            //     var url =
                            //         'https://shuttles.rpi.edu/static/Weekday.pdf';
                            //     if (await canLaunch(url)) {
                            //       await launch(url);
                            //     } else {
                            //       throw 'Could not launch $url';
                            //     }
                            //   },
                            //   child: Text('View PDF',
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 13)),
                            // ),
                            Text('No paper schedules this semester',
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
                      color: theme.getTheme.cardColor,
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
                            Text('''
North and West Routes
Saturday 9am – 11:45pm
Sunday 9am – 8pm

Hudson Valley College Suites Shuttles
Saturday–Sunday 7am – 7pm
                                ''',
                                style: TextStyle(
                                    color: theme.getTheme.hoverColor,
                                    fontSize: 13)),
                            // GestureDetector(
                            //   onTap: () async {
                            //     var url =
                            //         'https://shuttles.rpi.edu/static/Weekend.pdf';
                            //     if (await canLaunch(url)) {
                            //       await launch(url);
                            //     } else {
                            //       throw 'Could not launch $url';
                            //     }
                            //   },
                            //   child: Text('View PDF',
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 13)),
                            // ),
                            Text('No paper schedules this semester',
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
                ],
              ),
            ),
          ));
    });
  }
}
