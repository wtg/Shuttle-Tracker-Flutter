import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/shuttle/shuttle_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_image.dart';
import 'route_states/loaded_state.dart';
import 'route_states/loading_state.dart';

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
        return Center(child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
          print(state);
          if (state is ShuttleInitial || state is ShuttleError) { // TODO: MODIFY BLOC ERROR FOR ROUTE EVENT
            shuttleBloc.add(ShuttleEvent.getRoutes);
          } else if (state is ShuttleLoaded) {
            return LoadedState(
              routesJSON: state.routes,
              stopsJSON: state.stops,
              theme: theme,
            );
          }
          return LoadingState();
        }));
      },
    ));
  }
}
