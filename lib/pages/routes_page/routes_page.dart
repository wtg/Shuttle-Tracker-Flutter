import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
  //Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    //_refreshCompleter = Completer<void>();
    return PlatformScaffold(body: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, theme) {
        return Center(child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
          if (state is ShuttleInitial || state is ShuttleError) {
            // TODO: MODIFY BLOC ERROR FOR ROUTE EVENT
            shuttleBloc.add(ShuttleEvent.getRoutes);
          } else if (state is ShuttleLoaded) {
            return LoadedState(
              routes: state.routes,
              stops: state.stops,
              theme: theme.getTheme,
            );
            /*
            return RefreshIndicator(
              onRefresh: () {
                shuttleBloc.add(ShuttleEvent.getRoutes);
                return _refreshCompleter.future;
              },
              child: LoadedState(
                routes: state.routes,
                stops: state.stops,
                theme: theme,
              ),
            );
            */

          }
          return LoadingState();
        }));
      },
    ));
  }
}
