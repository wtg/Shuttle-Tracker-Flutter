import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/shuttle/shuttle_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_image.dart';
import '../../widgets/loading_state.dart';
import 'states/loaded_state.dart';

class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  ShuttleBloc shuttleBloc;
  bool isSwitched = false;
  Map<String, ShuttleImage> legend = {};
  Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
    _refreshCompleter = Completer<void>();
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Routes',
              style: TextStyle(
                color: theme.getTheme.hoverColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          body: Material(
            child: Center(child: BlocBuilder<ShuttleBloc, ShuttleState>(
                builder: (context, state) {
              shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
              if (state is ShuttleInitial || state is ShuttleError) {
                // TODO: MODIFY BLOC ERROR FOR ROUTE EVENT
                shuttleBloc.add(ShuttleEvent.getRoutesPageData);
              } else if (state is ShuttleLoaded) {
                return RefreshIndicator(
                  backgroundColor: theme.getTheme.appBarTheme.color,
                  onRefresh: () {
                    shuttleBloc.add(ShuttleEvent.getRoutesPageData);
                    return _refreshCompleter.future;
                  },
                  child: LoadedState(
                    routes: state.routes,
                    stops: state.stops,
                    theme: theme.getTheme,
                  ),
                );
              }
              return LoadingState(theme: theme.getTheme);
            })),
          ));
    });
  }
}
