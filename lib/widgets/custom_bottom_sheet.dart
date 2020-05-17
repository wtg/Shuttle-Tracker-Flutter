import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final String markerName;
  CustomBottomSheet({this.markerName});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
            style: TextStyle(color: Theme.of(context).hoverColor),
          ),
        ],
      )),
    );
  }
}
