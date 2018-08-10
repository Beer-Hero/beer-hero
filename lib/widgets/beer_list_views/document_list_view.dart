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
    beers.clear();
    for (final DocumentReference docReference in docReferences) {
      try {
        print('Trying to add ${docReference.documentID}');
        docReference.get().then((final DocumentSnapshot documentSnapshot) {
          setState(() {
            _addBeer(documentSnapshot);
          });
        }).catchError((error) {
          print('[DocumentListView] An error occured when waiting for futures');
          print('Error: $error');
        });
      } catch (error) {
        print('Failed to add ${docReference.documentID}');
        print('Error: $error');
      }
    }
  }

  void _addBeer(final DocumentSnapshot documentSnapshot) {
    final Beer beer = Beer.fromDocumentSnapshot(documentSnapshot);
    beers.add(beer);
    print('[DocumentListView] Setting state with ${beers.length} of ${docReferences.length} beers');
  }

  @override
  Widget build(BuildContext context) {
    print('[DocumentListView] Building with ${beers.length} of ${docReferences.length} beers');
    return new BeerListView(new List<Beer>.from(beers.reversed));
  }
}
