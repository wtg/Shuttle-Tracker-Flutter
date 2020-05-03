import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingState extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingState> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(
        ios: (_) => CupertinoProgressIndicatorData(radius: 20),
      ),
    );
  }
}
