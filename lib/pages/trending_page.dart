import 'package:beer_hero/widgets/beer_list_views/query_list_view.dart';
import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GlobalScaffold(
        titleText: 'Trending',
        body: new ListView(
          children: <Widget>[
            new QueryListView([Firestore.instance.collection('beers').limit(15)])
          ],
        ));
  }
}
