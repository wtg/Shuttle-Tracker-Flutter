import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class SocketTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  final channel = IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');

  void connectToSocket() {
    var topic = 'vehicle_location';
    var data = {"type": "subscribe", "message": topic};
    print(jsonEncode(data));
    channel.sink.add(jsonEncode(data));
    channel.stream.listen(print);
  }

  // bus button
  void sendToSocket() {
    var send =
        '{"type":"bus_button","message":{"latitude":42.729216,"longitude":-73.673618,"emojiChoice":"shirls"}}';
    channel.sink.add(send);
  }

  @override
  void initState() {
    super.initState();
//    connectToSocket();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sockets'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
//          child: StreamBuilder(
//            stream: channel.stream,
//            builder: (context, snapshot) {
//              return Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//              );
//            },
//          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendToSocket,
        child: Icon(Icons.send),
      ),
    );
  }
}
