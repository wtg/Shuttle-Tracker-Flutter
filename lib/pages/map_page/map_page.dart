import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';

import '../../blocs/shuttle/shuttle_bloc.dart';
import 'states/error_map.dart';
import 'states/initial_map.dart';
import 'states/loaded_map.dart';
import 'states/loading_map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    ShuttleBloc shuttleBloc = context.bloc<ShuttleBloc>();
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/img/logo.png',
            height: 40,
            width: 40,
          ),
          backgroundColor: theme.getTheme.appBarTheme.color,
          ios: (_) => CupertinoNavigationBarData(
            padding: EdgeInsetsDirectional.only(bottom: 10),
          ),
          android: (_) => MaterialAppBarData(centerTitle: true),
        ),
        body: Material(
          child: Center(
            child: BlocBuilder<ShuttleBloc, ShuttleState>(
                builder: (context, state) {
              if (state is ShuttleInitial) {
                shuttleBloc.add(ShuttleEvent.getShuttleMap);
                print('state is initial');
                return InitialMap();
              } else if (state is ShuttleError) {
                shuttleBloc.add(ShuttleEvent.getShuttleMap);
                print('state has error\n\n');
                return ErrorMap(
                  message: state.message,
                );
              } else if (state is ShuttleLoaded) {
                print('state is loaded');
                i++;
                print('API poll $i\n\n');
                shuttleBloc.add(ShuttleEvent.getShuttleMap);
                return LoadedMap(
                  routes: state.routes,
                  location: state.location,
                  stops: state.stops,
                  updates: state.updates,
                );
              }
              print('state is loading');
              return LoadingMap();
            }),
          ),
        ),
      );
    });
  }
}
