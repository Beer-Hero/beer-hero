import 'dart:async';

import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/widgets/beer_list_views/query_list_view.dart';
import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecommendationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RecommendationsPageState();
  }
}

class RecommendationsPageState extends State<RecommendationsPage> {
  List<String> styleNames;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((final DocumentSnapshot documentSnapshot) {
        final List<String> ids = new List<String>.from(documentSnapshot.data['likedBeers']);
        final List<Future<DocumentSnapshot>> documentSnapshots = [];
        for (final String id in ids) {
          documentSnapshots.add(Firestore.instance.collection('beers').document(id).get());
        }
        Future.wait(documentSnapshots).then((final List<dynamic> dynamicSnapshots) {
          setState(() {
            styleNames = [];
            final List<DocumentSnapshot> documentSnapshots = new List<DocumentSnapshot>.from(dynamicSnapshots);
            for (final DocumentSnapshot documentSnapshot in documentSnapshots) {
              final String styleName = Beer.fromDocumentSnapshot(documentSnapshot).styleName;
              if (styleName != null && styleName.isNotEmpty) {
                styleNames.add(styleName);
              }
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (styleNames == null) {
      return new GlobalScaffold(
          titleText: 'Recommendations',
          body: new Center(
            child: new CircularProgressIndicator(),
          ));
    }

    final List<Query> queries = [];
    for (final String styleName in styleNames) {
      queries.add(Firestore.instance.collection('beers').where('styleName', isEqualTo: styleName).limit(5));
    }

    return new GlobalScaffold(
        titleText: 'Recommendations',
        body: new ListView(
          children: <Widget>[
            new QueryListView(queries),
          ],
        ));
  }
}
