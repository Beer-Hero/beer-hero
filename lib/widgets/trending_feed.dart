import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TrendingFeedState();
  }
}

class TrendingFeedState extends State<TrendingFeed> {
  List<Beer> beers = [];

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('beers').limit(10).getDocuments().then((final QuerySnapshot snapshot) {
      print('Queried for ${snapshot.documents.length} beers');
      setState(() {
        beers.clear();
        for (final DocumentSnapshot documentSnapshot in snapshot.documents) {
          final Beer beer = Beer.fromDocumentSnapshot(documentSnapshot);
          beers.add(beer);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BeerCard> beerCards = [];
    for (final Beer beer in beers) {
      beerCards.add(new BeerCard(beer: beer));
    }

    return new Center(
      child: new ListView(
        children: beerCards,
      ),
    );
  }
}
