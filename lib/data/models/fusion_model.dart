import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../models/shuttle_update.dart';

class FusionSocket {
  String serverID;
  List<String> subscriptionTopics;
  IOWebSocketChannel channel;

  /// Start of the Fusion web socket functions
  /// Initialize a connection with the server, check if the server
  /// is already running or timed out
  void start() {
    channel = IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');

    channel.stream.listen((message) {
      // {"type":"server_id","message":"0ad35438-58bd-11ea-a696-0242ac110017"}
      var response = jsonDecode(message);
      if (response['type'] == 'server_id') {
        serverID = response['message'];
        return;
      } else if (response['type'] == 'vehicle_location') {
        handleVehicleLocations(message);
      }
    });
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
    var data = {'type': 'subscribe', 'message': topic};
    channel.sink.add(jsonEncode(data));
  }

  void _requestUnsubscription(String topic) {
    var data = {'type': 'unsubscribe', 'message': topic};
    channel.sink.add(jsonEncode(data));
  }

  List<ShuttleUpdate> handleVehicleLocations(String message) {
    var jsonMessage = jsonDecode(message);
    List<ShuttleUpdate> updatesList = jsonMessage != null
        ? json
            .decode(jsonMessage.body)
            .map<ShuttleUpdate>((json) => ShuttleUpdate.fromJson(json))
            .toList()
        : [];
    return updatesList;
  }
}
