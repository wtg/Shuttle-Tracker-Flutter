import 'package:flutter/material.dart';

class ETAPanel extends StatelessWidget {
  final String markerName;
  ETAPanel({this.markerName});

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
            '$markerName',
            style: TextStyle(
                color: Theme.of(context).hoverColor,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Add ETA data here")
        ],
      )),
    );
  }
}
