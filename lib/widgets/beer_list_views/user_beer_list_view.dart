import 'package:beer_hero/widgets/beer_list_views/document_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBeerListView extends StatefulWidget {
  final String fieldName;

  const UserBeerListView(this.fieldName);

  @override
  State<StatefulWidget> createState() {
    return new UserBeerListViewState(fieldName);
  }
}

class UserBeerListViewState extends State<UserBeerListView> {
  final String fieldName;

  List<DocumentReference> beerDocReferences;

  UserBeerListViewState(this.fieldName);

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((final DocumentSnapshot documentSnapshot) {
        setState(() {
          List<String> beerIds = new List<String>.from(documentSnapshot.data[fieldName]);
          print('[UserBeerListView] Getting ${beerIds.length} beer(s) from field [$fieldName]');
          List<DocumentReference> newList = [];
          for (final String beerId in beerIds) {
            newList.add(Firestore.instance.collection('beers').document(beerId));
          }
          beerDocReferences = newList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (beerDocReferences == null) {
      return new CircularProgressIndicator();
    }
    print('[UserBeerListView] Building with ${beerDocReferences.length} beer(s) from field [$fieldName]');
    return new DocumentListView(beerDocReferences);
  }
}
