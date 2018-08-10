import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_card.dart';
import 'package:flutter/material.dart';

class BeerListView extends StatelessWidget {
  final List<Beer> beers;

  const BeerListView(this.beers);

  @override
  Widget build(BuildContext context) {
    final List<BeerCard> beerCards = [];
    for (final Beer beer in beers) {
      if (beer == null) {
        continue;
      }

      beerCards.add(new BeerCard(beer: beer));
    }

    return new Center(
      child: new Column(
        children: beerCards,
      ),
    );
  }
}
