import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/routes_bloc/routes_bloc.dart';
import '../blocs/theme_bloc/theme_bloc.dart';
import '../widgets/loading_state.dart';
import '../widgets/shuttle_svg.dart';
import '../widgets/loaded_routes.dart';

/// Class: RoutesPage
/// Function: Widget that represents the main RoutesPage
class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

/// Class: _RoutesPageState
/// Function: Returns the state of the RoutesPage
class _RoutesPageState extends State<RoutesPage> {
  RoutesBloc routesBloc;
  bool isSwitched = false;
  Map<String, ShuttleSVG> legend = {};
  Completer<void> _refreshCompleter;

  /// Standard build function for the state of the widget
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
                color: theme.getTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(child:
              BlocBuilder<RoutesBloc, RoutesState>(builder: (context, state) {
            routesBloc = BlocProvider.of<RoutesBloc>(context);
            if (state is RoutesInitial || state is RoutesError) {
              // TODO: MODIFY BLOC ERROR FOR ROUTE EVENT
              routesBloc.add(RoutesEvent.getRoutesPageData);
            } else if (state is RoutesLoaded) {
              return RefreshIndicator(
                backgroundColor: theme.getTheme.appBarTheme.color,
                onRefresh: () {
                  routesBloc.add(RoutesEvent.getRoutesPageData);
                  return _refreshCompleter.future;
                },
                child: LoadedRoutes(
                  routes: state.routes,
                  darkRoutes: state.darkRoutes,
                  stops: state.stops,
                  theme: theme.getTheme,
                ),
              );
            }
            return LoadingScreen();
          })));
    });
  }
}
