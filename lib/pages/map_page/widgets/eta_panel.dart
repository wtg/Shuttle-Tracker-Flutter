import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shuttletracker/data/models/shuttle_eta.dart';
import 'package:http/http.dart';

import '../../../main.dart';

class ETAPanel extends StatefulWidget {
  final String markerName;

  ETAPanel({@required this.markerName});

  @override
  _ETAPanelState createState() => _ETAPanelState();
}

class _ETAPanelState extends State<ETAPanel> {
  List etaList = [];

  @override
  void initState() {
    super.initState();
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
          boxShadow: Theme.of(context).backgroundColor.toString() ==
                  "Color(0xffffffff)"
              ? [
                  BoxShadow(
                    color: Color(0xffD3D3D3),
                    blurRadius: 5.0,
                  )
                ]
              : null),
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
            stream: ws.streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var response = jsonDecode(snapshot.data);
                if (response['type'] == 'eta') {
                  etaList = ws.handleEtas(snapshot.data);
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      etaList.isNotEmpty ? '$etaList' : 'No ETAs calculated'),
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
