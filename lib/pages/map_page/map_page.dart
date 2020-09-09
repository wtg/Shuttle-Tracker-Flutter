import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

import '../../blocs/shuttle/shuttle_bloc.dart';
import '../../global_widgets/loading_state.dart';
import 'states/error_map.dart';
import 'states/initial_map.dart';
import 'states/loaded_map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    var shuttleBloc = context.bloc<ShuttleBloc>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/img/logo.png',
          height: 40,
          width: 40,
        ),
      ),
      body: Center(
        child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          if (state is ShuttleInitial) {
            shuttleBloc.add(ShuttleEvent.getMapPageData);
            print('state is initial');
            return InitialMap();
          } else if (state is ShuttleError) {
            shuttleBloc.add(ShuttleEvent.getMapPageData);
            print('state has error\n\n');
            return ErrorMap(
              message: state.message,
            );
          } else if (state is ShuttleLoaded) {
            print('state is loaded');
            i++;
            print('API poll $i\n\n');
            shuttleBloc.add(ShuttleEvent.getMapPageData);

            return LoadedMap(
              routes: state.routes,
              location: state.location,
              stops: state.stops,
              updates: state.updates,
            );
          }
          print('state is loading');
          return LoadingState();
        }),
      ),
    );
  }
}
