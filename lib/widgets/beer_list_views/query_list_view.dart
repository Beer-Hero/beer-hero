import 'dart:async';

import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_list_views/beer_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryListView extends StatefulWidget {
  final List<Query> queries;

  const QueryListView(this.queries);

  @override
  State<StatefulWidget> createState() {
    return new QueryListViewState(queries);
  }
}

class QueryListViewState extends State<QueryListView> {
  final List<Query> queries;

  List<Beer> beers = [];

  QueryListViewState(this.queries);

  @override
  void initState() {
    super.initState();

    final List<Future> futures = [];
    for (final Query query in queries) {
      futures.add(query.getDocuments());
    }
    Future.wait(futures).then((final List<dynamic> dynamicSnapshots) {
      print('[QueryListView] Futures returned: ${dynamicSnapshots.length}');
      final List<QuerySnapshot> querySnapshots = new List<QuerySnapshot>.from(dynamicSnapshots);
      setState(() {
        beers.clear();
        for (final QuerySnapshot querySnapshot in querySnapshots) {
          print('Queried for ${querySnapshot.documents.length} beers');
          for (final DocumentSnapshot documentSnapshot in querySnapshot.documents) {
            final Beer beer = Beer.fromDocumentSnapshot(documentSnapshot);
            beers.add(beer);
          }
        }
      });
    }).catchError(() {
      print('[QueryListView] An error occured when waiting for futures');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[QueryListView] Building with ${beers.length} of ${queries.length} beers');
    return new BeerListView(beers);
  }
}
