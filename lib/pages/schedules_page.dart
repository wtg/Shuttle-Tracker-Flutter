import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/blocs/theme_bloc/theme_bloc.dart';

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
                color: theme.getTheme.primaryColor,
                fontWeight: FontWeight.bold,
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
                      shadowColor: theme.getTheme.primaryColor,
                      color: theme.getTheme.cardColor,
                      elevation: theme.getThemeState ? 0 : 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text('Weekday Routes',
                                style: TextStyle(
                                    color: theme.getTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19)),
                            Text(''' 

North and West Routes
Monday – Friday 7am – 11:45pm

Hudson Valley College Suites Shuttles
Monday – Friday 7am – 7pm

CDTA Express Route
Monday – Friday 7am – 7pm
                                ''',
                                style: TextStyle(
                                    color: theme.getTheme.primaryColor,
                                    fontSize: 13)),
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
                      shadowColor: theme.getTheme.primaryColor,
                      color: theme.getTheme.cardColor,
                      elevation: theme.getThemeState ? 0 : 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text('Weekend Routes\n',
                                style: TextStyle(
                                    color: theme.getTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19)),
                            Text('''
North and West Routes
Saturday 9am – 11:45pm
Sunday 9am – 8pm

Hudson Valley College Suites Shuttles
Saturday – Sunday 7am – 7pm
                                ''',
                                style: TextStyle(
                                    color: theme.getTheme.primaryColor,
                                    fontSize: 13)),
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
