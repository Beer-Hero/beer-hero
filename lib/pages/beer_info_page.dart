import 'package:beer_hero/model/beer.dart';
import 'package:flutter/material.dart';

class BeerInfoPage extends StatelessWidget {
  final Beer beer;

  final TextStyle titleStyle = new TextStyle(fontSize: 20.0);
  final TextStyle detailStyle = new TextStyle(fontSize: 15.0);

  BeerInfoPage(this.beer);

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 20.0)),
            new Center(
              child: new Text(
                beer.name,
                style: titleStyle,
              ),
            ),
            new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            new Text(
              '${beer.brewerName}',
              textAlign: TextAlign.left,
              style: detailStyle,
            )
          ],
        ));
  }
}
