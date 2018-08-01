import 'package:beer_hero/widgets/beer_list_views/query_list_view.dart';
import 'package:beer_hero/widgets/beer_list_views/user_beer_list_view.dart';
import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DiscoverPageState();
  }
}

class DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController textEditingController = new TextEditingController();
  bool searching = false;
  List<Query> queries = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(DiscoverPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('UPDATED!');
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).primaryTextTheme.button.color;

    return new GlobalScaffold(
      titleText: 'Discover',
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        icon: new Icon(
                          Icons.search,
                          color: iconColor,
                        ),
                        fillColor: Colors.white,
                        filled: true),
                    onSubmitted: (final String searchText) {
                      _search();
                    },
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    onPressed: () {
                      //TODO: Open camera for upc search
                    },
                    child: new Icon(
                      Icons.camera,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
            new Padding(padding: EdgeInsets.only(top: 10.0)),
            new Flexible(
              child: new ListView(
                children: <Widget>[
                  _getRecentSearchColumn(context),
                  _getSearchColumn(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getRecentSearchColumn(final BuildContext context) {
    if (searching) {
      return new Container();
    }

    return new Column(
      children: <Widget>[
        new Text(
          'Recent Searches',
          style: Theme.of(context).primaryTextTheme.title,
        ),
        new Divider(color: Theme.of(context).primaryTextTheme.title.color),
        new UserBeerListView('recentSearches'),
      ],
    );
  }

  void _search() {
    final String searchText = textEditingController.text.trim();
    searching = searchText.isNotEmpty;
    if (!searching) {
      return;
    }

    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      this.setState(() {
        print('Creating query for [$searchText]');
        queries.clear();
        queries.add(Firestore.instance.collection('beers').where('name', isEqualTo: searchText));
      });
    });
  }

  Widget _getSearchColumn(final BuildContext context) {
    if (!searching || queries.isEmpty) {
      return new Container();
    }

    return new Column(
      children: <Widget>[
        new QueryListView(queries),
      ],
    );
  }
}
