import 'package:beer_hero/widgets/beer_list_views/user_beer_list_view.dart';
import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:flutter/material.dart';

class YourBeersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle style = new TextStyle(fontSize: 30.0, color: Theme.of(context).primaryTextTheme.title.color);

    return new GlobalScaffold(
      titleText: 'Your Beers',
      body: new ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Text(
            'Liked',
            textAlign: TextAlign.center,
            style: style,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: new Divider(
              color: Colors.white,
            ),
          ),
          new UserBeerListView('likedBeers'),
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Text(
            'Disliked',
            textAlign: TextAlign.center,
            style: style,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: new Divider(
              color: Colors.white,
            ),
          ),
          new UserBeerListView('dislikedBeers'),
        ],
      ),
    );
  }
}
