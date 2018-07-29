import 'dart:async';

import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_list_views/beer_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocumentListView extends StatefulWidget {
  final List<DocumentReference> docReferences;

  DocumentListView(this.docReferences);

  @override
  State<StatefulWidget> createState() {
    return new DocumentListViewState(docReferences);
  }
}

class DocumentListViewState extends State<DocumentListView> {
  final List<DocumentReference> docReferences;

  List<Beer> beers = [];

  DocumentListViewState(this.docReferences);

  @override
  void initState() {
    super.initState();

    update();
  }

  void update() {
    final List<Future> futures = [];
    for (final DocumentReference docReference in docReferences) {
      futures.add(docReference.get());
    }

    Future.wait(futures).then((final List<dynamic> dynamicSnapshots) {
      print('[DocumentListView] Futures returned: ${dynamicSnapshots.length}');
      final List<DocumentSnapshot> documentSnapshots = new List<DocumentSnapshot>.from(dynamicSnapshots);

      setState(() {
        beers.clear();
        for (final DocumentSnapshot documentSnapshot in documentSnapshots) {
          final Beer beer = Beer.fromDocumentSnapshot(documentSnapshot);
          beers.add(beer);
        }
        print('[DocumentListView] Setting state with ${beers.length} of ${docReferences.length} beers');
      });
    }).catchError(() {
      print('[DocumentListView] An error occured when waiting for futures');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[DocumentListView] Building with ${beers.length} of ${docReferences.length} beers');
    return new BeerListView(beers);
  }
}
