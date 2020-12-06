import 'dart:developer';
//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../blocs/fusion_bloc/fusion_bloc.dart';
import '../../../data/models/shuttle_eta.dart';


Map<int, String> stopIDs = {1 : "Student Union",
                            8 : "Blitman Residence Commons",
                            12 : "15th and College Ave.",
                            13 : "13th and Peoples Ave.",
                            14 : "Colonie Apartments",
                            15 : "Brinsmade Terrace",
                            11 : "Polytechnic Residence Commons",
                            10 : "6th Ave. and City Station",
                            18 : "BARH",
                            20 : "Winslow",
                            21 : "E Lot",
                            22 : "Tibbits Ave.",
                            23 : "LXA",
                            24 : "Sunset Terrace 1",
                            17 : "Sunset Terrace 2",
                            25 : "Sage Ave.",
                            26 : "Troy Building Crosswalk",
                            27 : "West Hall",
                            28 : "9th and Sage",
                            29 : "Ricketts Transfer",
                            30 : "Colonie Apartments",
                            31 : "Beman Park",
                            32 : "LXA Transfer",
                            33 : "Tibbets and Orchard",
                            34 : "Polytech Residence Commons",
                            36 : "Academy Hall Lot",
                            37 : "City Station",
                            38 : "Blitman Residence Commons",
                            35 : "CBIS Transfer",
                            39 : "Georgian",
                            40 : "North",
                            41 : "Armory Recreation Center",
};

/// Class: ETAPanel Widget
/// Function: Used to create an instance of the ETA Panel
class ETAPanel extends StatefulWidget {
  final String markerName;
  final bool stopMarker;

  /// Constructor of the ETAPanel Widget
  ETAPanel({@required this.markerName, this.stopMarker});

  @override
  _ETAPanelState createState() => _ETAPanelState();
}

/// Class: _ETAPanelState
/// Function: Provides the internal state of the ETAPanel Widget, contains
///           information read synchronously during the lifetime of the widget
class _ETAPanelState extends State<ETAPanel> {
  // Contains a list of the ETAs recieved from the server
  List<ShuttleETA> etaList = [];

  /// Standard Initialization function
  @override
  void initState() {
    super.initState();
  }

  /// Builds the internal content of the Widget
  Widget build(BuildContext context) {
    var panelColor = Theme.of(context).cardColor;
    return Container(
      decoration: BoxDecoration(
          color: panelColor,
          border: Border.all(
            width: 5,
            color: panelColor,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
          ),
          boxShadow: Theme.of(context).backgroundColor == Color(0xffffffff)
              ? [
                  BoxShadow(
                    color: Color(0xffD3D3D3),
                    blurRadius: 5.0,
                  )
                ]
              : null
          /*
                [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 1.0,
                  )
                ],
           */
          ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Center(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.clear, color: Theme.of(context).hoverColor),
                onPressed: () => Navigator.pop(context),
                splashRadius: 10,
              )
            ],
          ),
          FittedBox(
            child: Text(
              '${widget.markerName}',
              style: TextStyle(
                  color: widget.stopMarker
                      ? Theme.of(context).hoverColor
                      : Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<FusionBloc, FusionState>(
            builder: (context, state) {
              if (state is FusionETALoaded) {
                etaList = state.etas;
                for(var i = 0; i < state.etas.length; i++){
                  if (state.etas[i].arriving &&
                      stopIDs[state.etas[i].stopId] == widget.markerName){
                    etaList.add(state.etas[i]);
                  }
                }
                var now = new DateTime.now().toUtc();
                log('TIME NOW IS: $now');
              }
              var something = etaList.length;
              log("$something");
              return Expanded(
                child: etaList.isNotEmpty ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: 3,
                    itemBuilder: createTiles,
                /*
                children:
                    !etaList.isNotEmpty
                        ? <Widget>[
                              Text(
                                  "Testing",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25
                                  ),
                              ),
                              Text(
                                "Testing",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25
                                ),),
                              Text("Testing",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25
                                ),),
                            ]
                        : <Widget>[Text('No ETAs calculated')], */
                  ) : Text(
                          'No Shuttles Arriving',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 15
                      )
                  )
              );
            },
          )
        ],
      )),
    );
  }

  /// Builds a tile for the ETA Panel based on index
  Widget createTiles(BuildContext context, int index){
    return ListTile(
      dense: true,
      title:
          Text(
            "This is a test to see if there is any overflow with the text and "
                "if it wraps around",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15
            ),
          )
    );
  }
}
