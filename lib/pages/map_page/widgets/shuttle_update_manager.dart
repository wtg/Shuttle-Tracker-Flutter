import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/// Class: ShuttleUpdateManager widget
/// Function: Creates an instance of a manager widget that gets updates for
///           shuttles
class ShuttleUpdateManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShuttleUpdateManagerState();
}

/// Class: _ShuttleUpdateManagerState widget
/// Function: Creates the state of the update manager with a member variable
///           that contains a channel to the fusion socket
class _ShuttleUpdateManagerState extends State<ShuttleUpdateManager> {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect('wss://shuttles.rpi.edu/fusion/');

  /// Standard build function
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(); //Function is not implemented
  } //yet so it throws an error
}
