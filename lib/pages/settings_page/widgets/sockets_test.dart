import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/// Class: SocketTest
/// Function: returns a widget to test the web socket
class SocketTest extends StatefulWidget {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');
  @override
  State<StatefulWidget> createState() => _SocketTestState(channel: channel);
}

/// Class: _SocketTestState
/// Function: Represents the state of the socket test widget
class _SocketTestState extends State<SocketTest> {
  final IOWebSocketChannel channel;
  Text bodyText = Text("Empty");

  /// Constructor of the socket test state
  _SocketTestState({this.channel}) {
    channel.stream.listen((event) {
      setState(() {
        //var message = jsonDecode(event);
        bodyText = Text(event);
        //print("response from server ${message["message"]}");
      });
    });
  }

  /// Connects to web socket
  void connectToSocket() {
    var data = {
      "type": "subscribe",
      "message": {"topic": "vehicle_location"}
    };
    print("connectTOSocket ${jsonEncode(data)}");
    channel.sink.add(jsonEncode(data));
  }

  // bus button
  /// Sends data to the web socket (specifically bus button)
  void sendToSocket() {
    var send = {
      'type': 'bus_button',
      'message': {
        'latitude': 42.729216,
        'longitude': -73.673618,
        'emojiChoice': '🚓'
      }
    };
    channel.sink.add(jsonEncode(send));
    print(jsonEncode(send));
    //channel.stream.listen(print);
  }

  /// initiates web socket connection
  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  /// closes web socket connection
  @override
  void dispose() {
    // var data = {'type': 'unsubscribe', 'message': 'eta'};
    // print("disconnect " + jsonEncode(data));
    // channel.sink.add(jsonEncode(data));
    channel.sink.close();
    super.dispose();
  }

  /// Standard build function of the socket test widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sockets'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: bodyText,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendToSocket,
        child: Icon(Icons.send),
      ),
    );
  }
}
