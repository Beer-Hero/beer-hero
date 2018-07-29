import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/model/brewer.dart';
import 'package:beer_hero/tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BeerInfoPage extends StatefulWidget {
  final Beer beer;

  const BeerInfoPage({Key key, this.beer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new BeerInfoPageState(beer);
  }
}

class BeerInfoPageState extends State<BeerInfoPage> {
  final Beer beer;

  Brewer brewer;

  BeerInfoPageState(this.beer);

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      Firestore.instance
          .collection('brewers')
          .document(beer.brewerId)
          .get()
          .then((final DocumentSnapshot documentSnapshot) {
        setState(() {
          brewer = Brewer.fromDocumentSnapshot(documentSnapshot);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: new AppBar(
          title: new Text(beer.name),
          leading: new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Icon(
                Icons.arrow_back,
                color: Theme.of(context).buttonColor,
              )),
        ),
        body: new ListView(children: [_buildStyleCard(), _buildDescriptionCard(), _buildBrewerInfoCard()]));
  }

  _goToWebsite(final String websiteUrl) async {
    if (await canLaunch(websiteUrl)) {
      await launch(websiteUrl);
    } else {
      throw 'Could not launch $websiteUrl';
    }
  }

  _openMap(final Brewer brewer) async {
    final String url = new Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: 'maps/search/',
      queryParameters: {
        'api': '1',
        'query': '${brewer.name}, ${_buildAddress()}',
      },
    ).toString();

    print(_buildAddress());
    print(url);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _buildAddress({final String separator = ', ', final String townStateSeparator = ', '}) {
    return '${brewer.address1 != null && brewer.address1.isNotEmpty ? '${brewer.address1}' : ''}'
        '${brewer.address2 != null && brewer.address2.isNotEmpty ? '$separator${brewer.address2}' : ''}'
        '${brewer.city != null && brewer.city.isNotEmpty ? '$separator${brewer.city}' : ''}'
        '${brewer.state != null && brewer.state.isNotEmpty ? '$townStateSeparator${brewer.state}' : ''}'
        '${brewer.country != null && brewer.country.isNotEmpty ? '$separator${brewer.country}' : ''}';
  }

  Widget _buildStyleCard() {
    final bool hasStyleInfo = beer.tags.isNotEmpty ||
        (beer.styleName != null && beer.styleName.isNotEmpty) ||
        (beer.categoryName != null && beer.categoryName.isNotEmpty);
    if (!hasStyleInfo) {
      return new Container();
    }

    final List<Widget> tags = [];
    for (final String tag in beer.tags) {
      tags.add(new Chip(
        label: new Text(tag),
        backgroundColor: getTagColor(tag),
      ));
    }

    List<Widget> style = [
      new ListTile(
        leading: const Icon(Icons.style),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        title: new Text('Style'),
        subtitle: new Text(
          [
            beer.styleName != null && beer.styleName.isNotEmpty ? 'Style: ${beer.styleName}\n' : '',
            beer.categoryName != null && beer.categoryName.isNotEmpty ? 'Category: ${beer.categoryName}\n' : '',
            beer.ibu != null && beer.ibu.toString().isNotEmpty ? 'IBU: ${beer.ibu.toString()}\n' : '',
            beer.abv != null && beer.abv.toString().isNotEmpty ? 'ABV: ${beer.abv.toString()}%' : '',
          ].join(),
        ),
      ),
      new ButtonTheme.bar(
        child: new ButtonBar(
          children: tags,
        ),
      )
    ];

    return new Card(
      elevation: 10.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: style,
      ),
    );
  }

  Widget _buildDescriptionCard() {
    if (beer.description == null || beer.description.isEmpty) {
      return new Container();
    }

    return new Card(
      elevation: 10.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.description),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            title: new Text('Description'),
            subtitle: new Text(beer.description.trim()),
          ),
        ],
      ),
    );
  }

  Widget _buildBrewerInfoCard() {
    if (brewer != null) {
      List<Widget> brewerInfo = [
        new ListTile(
          leading: const Icon(Icons.location_city),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          title: new Text('Made by ${brewer.name}'),
          subtitle: new Text(_buildAddress(separator: '\n')),
        ),
      ];

      bool hasAddress = brewer.city != null && brewer.country != null;
      brewerInfo.add(new ButtonTheme.bar(
        // make buttons use the appropriate styles for cards
        child: new ButtonBar(
          children: <Widget>[
            brewer.website != null && brewer.website.isNotEmpty
                ? new Row(
                    children: <Widget>[
                      new Icon(Icons.web),
                      new FlatButton(
                        child: const Text('Website'),
                        onPressed: () {
                          _goToWebsite(brewer.website);
                        },
                      )
                    ],
                  )
                : null,
            hasAddress
                ? Row(
                    children: <Widget>[
                      new Icon(Icons.map),
                      new FlatButton(
                        child: const Text('Google Maps'),
                        onPressed: () {
                          _openMap(brewer);
                        },
                      ),
                    ],
                  )
                : null,
          ],
        ),
      ));

      return new Card(
        elevation: 10.0,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: brewerInfo,
        ),
      );
    }

    return new Container();
  }
}
