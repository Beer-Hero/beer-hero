import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).primaryTextTheme.title;
    return new GlobalScaffold(
        titleText: 'About',
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text('Description', style: textStyle.copyWith(fontSize: 35.0)),
                new Text(
                  'An application that gives out Beer recommendations based on what you scan into the app. Based on scanning habits and ratings of beers you drink the app can give you choices of new beers to try that you may like.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                new Padding(padding: EdgeInsets.all(40.0)),
                new Text('Team Members', style: textStyle.copyWith(fontSize: 35.0)),
                new Text('Jake Mathews', style: textStyle),
                new Text('Josh Berger', style: textStyle),
                new Text('Austin Rogers', style: textStyle),
              ],
            ),
          ),
        ));
  }
}
