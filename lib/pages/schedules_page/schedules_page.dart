import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';

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
            title: Text(
              "Schedules",
              style: TextStyle(color: theme.getTheme.hoverColor),
            ),
            backgroundColor: theme.getTheme.appBarTheme.color,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Text("\n"),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                    )),
                child: Text("\nWeekday Routes\n"),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                    )),
                child: Text("\nNorth, South, and New West Routes\n"
                    "Monday–Friday 7am – 11pm\n"),
              ),
              Container(
                color: Colors.white,
                child: Text("\n\n"),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                    )),
                child: Text("\nWeekend Routes\n"),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 0.2,
                    )),
                child: Text("\nWest and East Routes\n"
                    "Saturday–Sunday 9:30am – 5pm\n\n"
                    "Weekend Express Route\n"
                    "Saturday–Sunday 4:30pm – 8pm\n\n"
                    "Late Night Route\n"
                    "Friday–Saturday 8pm – 4am\n\n"),
              ),
            ],
          ));
    });
  }
}
