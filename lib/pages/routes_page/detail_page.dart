import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../models/shuttle_stop.dart';
import '../map_page/map_states/loaded_map.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final List<ShuttleStop> stops;
  final List<int> ids;
  final Color color;

  DetailPage({this.title, this.polyline, this.stops, this.ids, this.color});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  MapController mapController = MapController();

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  List<Marker> _createStops(List<ShuttleStop> stops) {
    var markers = <Marker>[];

    for (var stop in stops) {
      if (widget.ids.contains(stop.id)) {
        markers.add(stop.getMarker(animatedMapMove));
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //notification listender used to remove scroll glow
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: ListView(
            controller: sc,
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Shuttle Stops",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _button("Popular", Icons.favorite, Colors.blue),
                  _button("Food", Icons.restaurant, Colors.red),
                  _button("Events", Icons.event, Colors.amber),
                  _button("More", Icons.more_horiz, Colors.green),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Images",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("About",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                    """,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, theme) {
      var isDarkMode = theme.bottomAppBarColor == Colors.black;
      var _panelHeightOpen = MediaQuery.of(context).size.height * .80;
      return PlatformScaffold(
          appBar: PlatformAppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: widget.color,
              ios: (_) => CupertinoNavigationBarData(
                  actionsForegroundColor: Colors.white)),
          body: SlidingUpPanel(
            panelBuilder: (sc) => _panel(sc),
            maxHeight: _panelHeightOpen,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: Column(
              children: [
                /// Map
                Flexible(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      nePanBoundary: LatLng(42.78, -73.63),
                      swPanBoundary: LatLng(42.68, -73.71),
                      center: LatLng(42.731, -73.6767),
                      zoom: 14,
                      maxZoom: 16, // max you can zoom in
                      minZoom: 13, // min you can zoom out
                    ),
                    layers: [
                      TileLayerOptions(
                        backgroundColor: theme.bottomAppBarColor,
                        urlTemplate: isDarkMode
                            ? LoadedMap.darkLink
                            : LoadedMap.lightLink,
                        subdomains: ['a', 'b', 'c'],
                        tileProvider: CachedNetworkTileProvider(),
                      ),
                      PolylineLayerOptions(polylines: widget.polyline),
                      MarkerLayerOptions(markers: _createStops(widget.stops)),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
