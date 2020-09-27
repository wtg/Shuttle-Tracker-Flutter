import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../models/shuttle_eta.dart';
import '../models/shuttle_update.dart';

class FusionSocket {
  String serverID;
  List<String> subscriptionTopics = [];
  IOWebSocketChannel channel;
  List<ShuttleETA> etas = [];

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
    var data = {
      'type': 'subscribe',
      'message': {'topic': topic}
    };
    channel.sink.add(jsonEncode(data));
  }

  void _requestUnsubscription(String topic) {
    var data = {
      'type': 'unsubscribe',
      'message': {'topic': topic}
    };
    channel.sink.add(jsonEncode(data));
  }

  // Use the data here to force an update to shuttles on the map
  List<ShuttleUpdate> handleVehicleLocations(String message) {
    var jsonMessage = jsonDecode(message);
    print("fusion data ${jsonMessage['message']}");

    // List<ShuttleUpdate> updatesList = jsonMessage != null
    //     //     ? json
    //     //         .decode(jsonMessage)
    //     //         .map<ShuttleUpdate>((json) => ShuttleUpdate.fromJson(json))
    //     //         .toList()
    //     //     : [];
    //     // print(updatesList);
    // return updatesList;
    return null;
  }

  void sendToSocket(String message) {
    print("sending $message");
    channel.sink.add(message);
  }

  // Each time a panel is opened, the eta data will come from
  // a member variable keeping track of all etas.
  void handleEtas(String message) {
    var data = jsonDecode(message);
    print("fusion data ${data['message']}");
    Map<String, dynamic> map = data['message'];
    List<dynamic> body = map['stop_etas'];
    print("body $body");
    for (var item in body) {
      print(item);
      print(data['message']['vehicle_id']);
      var eta = ShuttleETA(
          stopId: int.parse(item['stop_id']),
          /*TODO: Recieved error here: Unhandled Exception: 
              type 'int' is not a subtype of type 'String' */

          vehicleId: int.parse(data['message']['vehicle_id']),
          routeId: int.parse(data['message']['route_id']),
          eta: DateTime(item['eta']),
          arriving: item['arriving']);
      etas.add(eta);
      print("eta $eta");
    }
    print("etas $etas");
  }

  // Since dart doesn't really support deep copies of lists, we
  // have to keep in mind that we can't change the return value
  // of this function. All copies of the list will contain
  // references
  List<ShuttleETA> getETAs() {
    return etas;
  }
}
