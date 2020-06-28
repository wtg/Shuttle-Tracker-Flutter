import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ShuttleUpdateManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShuttleUpdateManagerState();
}

class _ShuttleUpdateManagerState extends State<ShuttleUpdateManager> {
	final IOWebSocketChannel channel =
	IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
