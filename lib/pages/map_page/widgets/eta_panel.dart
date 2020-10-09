import 'package:flutter/material.dart';

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
  List etaList = [];

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
          boxShadow: Theme.of(context).backgroundColor.toString() ==
                  "Color(0xffffffff)"
              ? [
                  BoxShadow(
                    color: Color(0xffD3D3D3),
                    blurRadius: 5.0,
                  )
                ]
              :
                  null
//                [
//                  BoxShadow(
//                    color: Colors.blueGrey,
//                    blurRadius: 1.0,
//                  )
//                ],
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
          Text(
            '${widget.markerName}',
            style: TextStyle(
                color: widget.stopMarker
                    ? Theme.of(context).hoverColor
                    : Colors.blue,
                fontSize: 27,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          //StreamBuilder(
          //  stream: ws.streamController.stream,
          //  builder: (context, snapshot) {
          //    if (snapshot.hasData) {
          //      var response = jsonDecode(snapshot.data);
          //      if (response['type'] == 'eta') {
          //        etaList = ws.handleEtas(snapshot.data);
          //      }
          //      return Padding(
          //        padding: const EdgeInsets.all(8.0),
          //        child: Text(
          //            etaList.isNotEmpty ? '$etaList' : 'No ETAs calculated'),
          //      );
          //    }
          //    return CircularProgressIndicator();
          //  },
          //)
        ],
      )),
    );
  }

  /* For Debugging Purposes */
  // void logThis(String message) {
  //   log(message);
  // }
}
