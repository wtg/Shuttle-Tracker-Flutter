import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

import '../models/shuttle_eta.dart';
import '../models/shuttle_update.dart';

class FusionSocket {
  String serverID;
  List<String> subscriptionTopics = [];
  IOWebSocketChannel channel;
  StreamController<String> streamController = StreamController.broadcast();

  /// Start of the Fusion web socket functions
  /// Initialize a connection with the server, check if the server
  /// is already running or timed out
  void openWS() {
    channel = IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');
  }

  void closeWS() {
    channel.sink.close();
  }

  /// Subscribe to certain socket channels
  /// Tells the server to update this listener
  /// with information
  void subscribe(String topic) {
    subscriptionTopics.add(topic);
    _requestSubscription(topic);
  }

  /// Remove subscription
  void unsubscribe(String topic) {
    subscriptionTopics.remove(topic);
    _requestUnsubscription(topic);
  }

  /// Used to request the socket to provide subscription
  void _requestSubscription(String topic) {
    var data = {
      'type': 'subscribe',
      'message': {'topic': topic}
    };
    channel.sink.add(jsonEncode(data));
  }

  /// Used to request the socket to unsubscribe
  void _requestUnsubscription(String topic) {
    var data = {
      'type': 'unsubscribe',
      'message': {'topic': topic}
    };
    channel.sink.add(jsonEncode(data));
  }

  // Use the data here to force an update to shuttles on the map
  /*
    private handleVehicleLocations(message: any) {
        if (message.type !== 'vehicle_location') {
            return;
        }

        const m = message.message;
        const location = new Location(
            m.id,
            m.vehicle_id,
            new Date(m.created),
            new Date(m.time),
            m.latitude,
            m.longitude,
            m.heading,
            m.speed,
            m.route_id,
        );
        store.commit('updateVehicleLocation', location);
    }

 {id: 14436992,
  tracker_id: 4572001071,
  latitude: 42.66648,
  longitude: -73.74309,
  heading: 14,
  speed: 20.87807273864746,
  time: 2020-08-28T11:19:15-04:00,
  created: 2020-09-29T12:31:11.335133-04:00,
  vehicle_id: 17,
  route_id: null}
  */
  /// Prints and returns updates on Vehicle Locations
  Future<ShuttleUpdate> handleVehicleLocations(String message) async {
    var data = await compute(jsonDecode, message);
    var update = ShuttleUpdate.fromJson(data['message']);
    print('update $update');
    return update;
  }

  /// Sends a String message to socket and prints message
  void sendToSocket(String message) {
    print('sending $message');
    channel.sink.add(message);
  }

  // Each time a panel is opened, the eta data will come from
  // a member variable keeping track of all etas.
  // Can probably clean up this code a bit.
  // Clear the old etas from list
  /// Decodes and returns a list of etas from input message
  List<ShuttleETA> handleEtas(String message) {
    var etas = <ShuttleETA>[];
    var data = jsonDecode(message);
    List<dynamic> body = data['message']['stop_etas'];
    for (var item in body) {
      var eta = ShuttleETA(
          stopId: item['stop_id'],
          vehicleId: data['message']['vehicle_id'],
          routeId: data['message']['route_id'],
          eta: DateTime.parse(item['eta']),
          arriving: item['arriving']);
      etas.add(eta);
      print('eta $eta');
    }
    print('etas $etas');
    return etas;
  }
}
