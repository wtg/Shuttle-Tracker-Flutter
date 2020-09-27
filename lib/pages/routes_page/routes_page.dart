import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/routes/routes_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../global_widgets/loading_state.dart';
import '../../global_widgets/shuttle_arrow.dart';
import 'states/loaded_routes.dart';

class RoutesPage extends StatefulWidget {
  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  RoutesBloc routesBloc;
  bool isSwitched = false;
  Map<String, ShuttleSVG> legend = {};
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
