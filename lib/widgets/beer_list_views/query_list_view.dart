import 'dart:async';

import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_list_views/beer_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QueryListView extends StatefulWidget {
  final List<Query> queries;
  final bool uploadRecent;
  final bool shuffle;

  const QueryListView(this.queries, {this.uploadRecent = false, this.shuffle = true});

  @override
  State<StatefulWidget> createState() {
    return new QueryListViewState(queries, uploadRecent, shuffle);
  }
}

class QueryListViewState extends State<QueryListView> {
  final List<Query> queries;
  final bool uploadRecent;
  final bool shuffle;

  List<Beer> beers = [];

  QueryListViewState(this.queries, this.uploadRecent, this.shuffle);

  @override
  void didUpdateWidget(QueryListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    update();
  }

  @override
  void initState() {
    super.initState();

    update();
  }

  void update() {
    final List<Future> futures = [];
    for (final Query query in queries) {
      print(query.buildArguments());
      futures.add(query.getDocuments());
    }
    Future.wait(futures).then((final List<dynamic> dynamicSnapshots) {
      print('[QueryListView] Futures returned: ${dynamicSnapshots.length}');
      final List<QuerySnapshot> querySnapshots = new List<QuerySnapshot>.from(dynamicSnapshots);
      setState(() {
        beers.clear();
        for (final QuerySnapshot querySnapshot in querySnapshots) {
          print('[QueryListView] Queried for ${querySnapshot.documents.length} beers');
          for (final DocumentSnapshot documentSnapshot in querySnapshot.documents) {
            final Beer beer = Beer.fromDocumentSnapshot(documentSnapshot);
            beers.add(beer);
          }
        }
        if (uploadRecent == true && beers.length > 0) {
          FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
            Firestore.instance
                .collection('users')
                .document(firebaseUser.uid)
                .get()
                .then((final DocumentSnapshot documentSnapshot) {
              final List<String> recentBeerIds = new List<String>.from(documentSnapshot.data['recentSearches']);
              final String newBeerId = beers[0].beerId;
              if (!recentBeerIds.contains(newBeerId)) {
                if (recentBeerIds.length >= 5) {
                  recentBeerIds.removeAt(0);
                }
                recentBeerIds.add(beers[0].beerId);
                Firestore.instance.collection('users').document(firebaseUser.uid).updateData(<String, dynamic>{
                  'recentSearches': recentBeerIds,
                });
              }
            });
          });
        }
        if (this.shuffle) {
          beers.shuffle();
        }
      });
    }).catchError(() {
      print('[QueryListView] An error occured when waiting for futures');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[QueryListView] Building with ${beers.length} beers from ${queries.length} queries');
    return new BeerListView(new List<Beer>.from(beers));
  }
}
