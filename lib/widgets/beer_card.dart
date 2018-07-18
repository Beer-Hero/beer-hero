import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/pages/beer_info_page.dart';
import 'package:flutter/material.dart';

class BeerCard extends StatelessWidget {
  final Beer beer;

  const BeerCard(this.beer);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.local_drink),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            title: new Text(beer.name),
            subtitle: new Text('${beer.category != null ? 'Category: ${beer.category}\n' : ''}'
                '${beer.style != null ? 'Style: ${beer.style}' : ''}'),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('More Info'),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (final BuildContext context) {
                        return new BeerInfoPage(beer);
                      },
                    ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
