import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/theme_bloc/theme_bloc.dart';
import 'hyperlink.dart';

class Attribution extends StatelessWidget {
  final ThemeData theme;
  Attribution({this.theme});

  Widget build(BuildContext context) {
    var attribution1 = <Widget>[
      Text(
        'Map tiles: ',
        style: theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: theme, url: 'https://stamen.com/', text: 'Stamen Design '),
      Text(
        '(',
        style: theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: theme,
          url: 'https://creativecommons.org/licenses/by/3.0/',
          text: 'CC BY 3.0'),
      Text(
        ')',
        style: theme.textTheme.subtitle1,
      ),
    ];

    var attribution2 = <Widget>[
      Text(
        'Data: ',
        style: theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: theme,
          url: 'https://www.openstreetmap.org/',
          text: 'OpenStreetMap '),
      Text(
        '(',
        style: theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: theme,
          url: 'https://www.openstreetmap.org/copyright',
          text: 'ODbL'),
      Text(
        ')',
        style: theme.textTheme.subtitle1,
      ),
    ];
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Positioned(
        bottom: 15,
        right: 5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: state.getThemeState
                  ? null
                  : [
                      BoxShadow(
                          color: Colors.grey, // Changed from black
                          blurRadius: 1.0,
                          offset: Offset(0.0, 0.5))
                    ]),
          padding: const EdgeInsets.all(5.0),
          child: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: attribution1,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: attribution2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
