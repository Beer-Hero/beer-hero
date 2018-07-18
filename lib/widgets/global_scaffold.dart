import 'package:flutter/material.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget body;

  const GlobalScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle style = new TextStyle(fontSize: 17.0);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Beer Hero'),
      ),
      drawer: new Drawer(
        child: new ListView(
          scrollDirection: Axis.vertical,
          physics: new ScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new ListTile(
                title: new Text(
                  'Beer Hero',
                  style: new TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                leading: new Image(
                  width: 100.0,
                  image: new AssetImage('assets/beer-mug.png'),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.trending_up),
              title: Text(
                'Trending',
                style: style,
              ),
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.lightbulb_outline),
              title: Text(
                'Recommendations',
                style: style,
              ),
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.search),
              title: Text(
                'Discover',
                style: style,
              ),
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.receipt),
              title: Text(
                'Your Beers',
                style: style,
              ),
            ),
            new Divider()
          ],
        ),
      ),
      body: this.body,
    );
  }
}
