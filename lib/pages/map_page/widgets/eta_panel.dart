import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/fusion/fusion_socket.dart';

class ETAPanel extends StatefulWidget {
  final String markerName;

  ETAPanel({@required this.markerName});

  @override
  _ETAPanelState createState() => _ETAPanelState();
}

class _ETAPanelState extends State<ETAPanel> {
  final FusionSocket ws = FusionSocket();

  @override
  void initState() {
    ws.openWS();
    ws.subscribe("eta");

    super.initState();
  }

  @override
  void dispose() {
    ws.closeWS();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
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
              )
            ],
          ),
          Text(
            '${widget.markerName}',
            style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Add ETA data here"),

        ],
      )),
    );
  }
}
