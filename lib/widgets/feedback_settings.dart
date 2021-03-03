import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme_bloc/theme_bloc.dart';

/// Class: FeedbackSettings
/// Function: Represents the Feedback section of the Settings Page
class FeedbackSettings extends StatelessWidget {
  /// Standard build function for the FeedbackSettings widget
  @override
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var theme = themeBloc.state.getTheme;
    var feedbackSettingsList = <Widget>[
      ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Send Feedback',
              style: TextStyle(color: theme.hoverColor, fontSize: 16),
            ),
            Text(
              'Any comments? Send them here!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      ListTile(
        dense: true,
        leading: Text(
          'Rate this app',
          style: TextStyle(color: theme.hoverColor, fontSize: 16),
        ),
      ),
    ];
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Text(
            'Feedback',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: feedbackSettingsList.length,
            itemBuilder: (context, index) => feedbackSettingsList[index],
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[600],
                height: 4,
                indent: 15.0,
              );
            },
          ),
        )
      ],
    );
  }
}
