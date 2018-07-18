import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_card.dart';
import 'package:flutter/material.dart';

class TrendingFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new ListView(
        children: <Widget>[
          new BeerCard(new Beer(name: 'Samuel Adams Boston Lager', style: 'Boston', category: 'Pale Ale')),
        ],
      ),
    );
  }
}
