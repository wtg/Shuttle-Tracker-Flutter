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
    // ws.unsubscribe("eta");
    ws.closeWS();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          width: 5,
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
        ),
        boxShadow:
        Theme.of(context).backgroundColor.toString() == "Color(0xffffffff)"
          ? [BoxShadow(
              color: Color(0xffD3D3D3),
              blurRadius: 5.0,
        )] : null
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
              )
            ],
          ),
          Text(
            '${widget.markerName}',
            style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 27,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder(
            stream: ws.channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data),
                );
              }
              return CircularProgressIndicator();
            },
          )
        ],
      )),
    );
  }
}
