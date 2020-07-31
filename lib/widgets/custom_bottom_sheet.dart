import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String markerName;
  CustomBottomSheet({this.markerName});

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
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
            style: TextStyle(color: Theme.of(context).hoverColor),
          ),
        ],
      )),
    );
  }
}
