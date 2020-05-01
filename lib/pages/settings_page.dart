import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  //basic info button
  bool send_position_update = false;
  bool bus_buttom = false;
  bool Estimated_times_of_arrival = false;

  //route button
  bool West_Campus = false;
  bool Weekend_Late_Night = false;
  bool East_Campus = false;
  bool New_South_Route = false;
  bool New_North_Route = false;
  bool New_West_Route = false;
  bool South_Inclement_Weather = false;
  bool North_Inclement_Weather = false;

  //basic info button function(need to add codes to make sure it works)
  OnSendPosition(bool send_on){
    setState(() {
      send_position_update = send_on;
    });
  }

  OnBusButtom(bool bus_on){
    setState(() {
      bus_buttom = bus_on;
    });
  }

  OnEstimatedArrival(bool arrival_on){
    setState(() {
      Estimated_times_of_arrival = arrival_on;
    });
  }

  //route button function(need to add codes to make sure it works)
  OnWestCampus(bool WC_on){
    setState(() {
      West_Campus = WC_on;
    });
  }

  OnWeekend_LateNight(bool W_LN){
    setState(() {
      Weekend_Late_Night = W_LN;
    });
  }

  OnEastCampus(bool EC_on){
    setState(() {
      East_Campus = EC_on;
    });
  }

  OnNewSouthRoute(bool NSR_on){
    setState(() {
      New_South_Route = NSR_on;
    });
  }

  OnNewNorthRoute(bool NNR_on){
    setState(() {
      New_North_Route = NNR_on;
    });
  }

  OnNewWestRoute(bool NWR_on){
    setState(() {
      New_West_Route = NWR_on;
    });
  }

  OnSouth_Inclement_Weather(bool SIW_on){
    setState(() {
      South_Inclement_Weather = SIW_on;
    });
  }

  OnNorth_Inclement_Weather(bool NIW_on){
    setState(() {
      North_Inclement_Weather = NIW_on;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SettingsPage'),
        ),

        body: ListView(children: <Widget>[

          SwitchListTile(
            title: new Text("Send Position Update"),
            activeColor: Colors.red,
            value: send_position_update,
            onChanged: (bool _send_on){OnSendPosition(_send_on);},

          ),

          Container(
            child: Text(
              "Use your location to help make Shuttle Tracker more accurate for everyone. "
                  "Your location is gathered anonymously while Shuttle Tracker is open.\n",
            ),
          ),

          SwitchListTile(
            title: new Text("Bus Buttom"),
            activeColor: Colors.red,
            value: bus_buttom,
            onChanged: (bool _bus_buttom){OnBusButtom(_bus_buttom);},

          ),

          Container(
            child: Text(
              "Place a bus on other users' maps and let others place buses on your map.\n",
            ),
          ),

          SwitchListTile(
            title: new Text("Estimated times of arrival"),
            activeColor: Colors.red,
            value: Estimated_times_of_arrival,
            onChanged: (bool _arrival_on){OnEstimatedArrival(_arrival_on);},

          ),

          Container(
            child: Text(
              "Get notifications when a shuttle is likely to arrive at the stop nearest you. Requires access to your location.",
            ),
          ),

          Text(
            "Warning: this feature is experimental. You’re not allowed to get mad at us if you miss your shuttle.\n\n\n",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: Text(
              "\t\t\t\tName Enable",
              style: TextStyle(wordSpacing: 290),
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("West Campus", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: West_Campus,
              onChanged: (bool _WC_on){OnWestCampus(_WC_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("Weekend/Late Night", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: Weekend_Late_Night,
              onChanged: (bool _W_LN){OnWeekend_LateNight(_W_LN);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("East Campus", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: East_Campus,
              onChanged: (bool _EC_on){OnEastCampus(_EC_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("New South Route", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: New_South_Route,
              onChanged: (bool _NSR_on){OnNewSouthRoute(_NSR_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("New North Route", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: New_North_Route,
              onChanged: (bool _NNR_on){OnNewNorthRoute(_NNR_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("New West Route", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: New_West_Route,
              onChanged: (bool _NWR_on){OnNewWestRoute(_NWR_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("South Inclement Weather", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: South_Inclement_Weather,
              onChanged: (bool _SIW_on){OnSouth_Inclement_Weather(_SIW_on);},
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.2,
                )
            ),
            child: SwitchListTile(
              title: new Text("North Inclement Weather", style: TextStyle(fontSize: 12)),
              activeColor: Colors.red,
              value: North_Inclement_Weather,
              onChanged: (bool _NIW_on){OnNorth_Inclement_Weather(_NIW_on);},
            ),
          ),
        ]
        ));
  }
}
