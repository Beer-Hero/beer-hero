import 'package:beer_hero/model/beer.dart';
import 'package:flutter/material.dart';

class BeerInfoPage extends StatelessWidget {
  final Beer beer;

  const BeerInfoPage(this.beer);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Beer Info'),
        leading: new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Icon(
              Icons.arrow_back,
              color: Theme.of(context).buttonColor,
            )),
      ),
      body: new Column(
        children: <Widget>[
          new Text(beer.name),
        ],
      ),
    );
  }
}
