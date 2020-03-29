import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

import '../bloc/shuttle_bloc.dart';
import '../widgets/states.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ShuttleBloc shuttleBloc;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var isDarkMode = false;
    if (brightness == Brightness.dark) {
      isDarkMode = true;
    }
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);

          if (state is ShuttleInitial) {
            shuttleBloc.add(GetShuttleMap());
            print('state is initial');
            return buildInitialState();
          } else if (state is ShuttleError) {
            shuttleBloc.add(GetShuttleMap());
            print('state has error\n\n');
            return buildErrorState(state.message, isDarkMode);
          } else if (state is ShuttleLoaded) {
            print('state is loaded');
            shuttleBloc.add(RefreshShuttleMap());
            return buildLoadedState(state.routes, state.location, state.stops,
                state.updates, state.mapkey, isDarkMode);
          }
          print('state is loading');
          return buildLoadingState();
        }),
      ),
    );
  }
}
