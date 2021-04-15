import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/blocs/theme_bloc/theme_bloc.dart';

class PlatformSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var isSwitched = themeBloc.state.isDarkMode;

    return Platform.isIOS
        ? CupertinoSwitch(
            value: isSwitched,
            onChanged: (value) {
              isSwitched = value;
              themeBloc.add(ThemeEvent.toggle);
            },
            activeColor: Colors.white,
            trackColor: Colors.green,
          )
        : Switch(
            value: isSwitched,
            onChanged: (value) {
              isSwitched = value;
              themeBloc.add(ThemeEvent.toggle);
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
          );
  }
}
