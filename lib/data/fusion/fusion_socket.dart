import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../models/shuttle_eta.dart';
import '../models/shuttle_update.dart';


class FusionSocket {
  String serverID;
  List<String> subscriptionTopics = [];
  IOWebSocketChannel channel;

  /// Start of the Fusion web socket functions
  /// Initialize a connection with the server, check if the server
  /// is already running or timed out
  void openWS() {
    channel = IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');

    channel.stream.listen((message) {
      // {"type":"server_id","message":"0ad35438-58bd-11ea-a696-0242ac110017"}
      var response = jsonDecode(message);
      if (response['type'] == 'server_id') {
        serverID = response['message'];
        print(serverID);
        return;
      } else if (response['type'] == 'vehicle_location') {
        handleVehicleLocations(message);
      } else if (response['type'] == 'eta') {
        handleEtas(message);
      }
    });
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

  void _requestSubscription(String topic) {
    var data = {'type': 'subscribe', 'message': {'topic': topic}};
    channel.sink.add(jsonEncode(data));
  }

  void _requestUnsubscription(String topic) {
    var data = {'type': 'unsubscribe', 'message': {'topic': topic}};
    channel.sink.add(jsonEncode(data));
  }

  List<ShuttleUpdate> handleVehicleLocations(String message) {
    var jsonMessage = jsonDecode(message);
    List<ShuttleUpdate> updatesList = jsonMessage != null
        ? json
            .decode(jsonMessage)
            .map<ShuttleUpdate>((json) => ShuttleUpdate.fromJson(json))
            .toList()
        : [];
    print(updatesList);
    return updatesList;
  }

  void sendToSocket(String message) {
    print("sending $message");
    channel.sink.add(message);
  }

  /*
   private handleETAs(message: any) {
        if (message.type !== 'eta') {
            return;
        }

        const etas = new Array<ETA>();
        for (const stopETA of message.message.stop_etas) {
            const eta = new ETA(
                stopETA.stop_id,
                message.message.vehicle_id,
                message.message.route_id,
                new Date(stopETA.eta),
                stopETA.arriving,
            );
            etas.push(eta);
        }
        store.commit('updateETAs', { vehicleID: message.message.vehicle_id, etas });
    }
   */

  List<ShuttleETA> handleEtas(message) {
    var etas = <ShuttleETA>[];
    var data = jsonDecode(message);
    print("fusion data ${data["message"]['stop_etas']}");
    for (var item in data["message"]['stop_etas']) {
      var temp = jsonDecode(item);
      var eta = new ShuttleETA(

      );
    }
    return null;
  }
}
