import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

import '../bloc/shuttle_bloc.dart';
import '../ui/states/error_map.dart';
import '../ui/states/initial_map.dart';
import '../ui/states/loaded_map.dart';
import '../ui/states/loading_map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ShuttleBloc shuttleBloc;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDarkMode
          ? Brightness.light
          : Brightness.dark, //android navigation bar color
      statusBarColor:
          isDarkMode ? Colors.black : Colors.white, // status bar color
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ));
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);

          if (state is ShuttleInitial) {
            shuttleBloc.add(GetShuttleMap());
            print('state is initial');
            return InitialMap();
          } else if (state is ShuttleError) {
            shuttleBloc.add(GetShuttleMap());
            print('state has error\n\n');
            return ErrorMap(message: state.message, isDarkMode: isDarkMode);
          } else if (state is ShuttleLoaded) {
            print('state is loaded');
            i++;
            print('API poll $i');
            shuttleBloc.add(GetShuttleMap());
            return LoadedMap(
                routes: state.routes,
                location: state.location,
                stops: state.stops,
                updates: state.updates,
                isDarkMode: isDarkMode);
          }
          print('state is loading');
          return LoadingMap();
        }),
      ),
    );
  }
}
