import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/pages/routes_page/widgets/panel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:latlong/latlong.dart';

import '../../../blocs/on_tap_eta/on_tap_eta_bloc.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../models/shuttle_stop.dart';

class ETAPanel extends StatefulWidget {

  final MapCallback animate;
  final OnTapEtaBloc bloc;
  ETAPanel({this.animate, this.bloc});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<ETAPanel> {
  String selectedName;
  ItemScrollController scrollController = ItemScrollController();



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme){
      return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: BlocBuilder<OnTapEtaBloc, OnTapEtaState>(
              cubit: widget.bloc,
              builder: (context, state) {
                if (state is MainTappedState){
                  selectedName = state.stopName;
                  if (state.index != null && scrollController.isAttached){
                    scrollController.scrollTo(
                      index: state.index,
                      duration: Duration(milliseconds: 250)
                    );
                  }
                }
                var _arrayList = [Text('hello'),Text('this is a test'),
                  Text('please work')];
                return Container(
                  color: theme.getTheme.backgroundColor,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child:  Text(
                          "$selectedName",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Get ETA List Here"),
                      ),
                    ],
                    /**
                    child: Align(
                      alignment: Alignment.topCenter,
                      child:  Text(
                        "$selectedName",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    )**/
                  ),
                );
              }),
          ),
      );
    });
  }
}

typedef MapCallback = void Function(LatLng pos, double zoom);

class ETALists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}