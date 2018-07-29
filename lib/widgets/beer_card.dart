import 'package:beer_hero/model/beer.dart';
import 'package:beer_hero/pages/beer_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BeerCard extends StatefulWidget {
  final Beer beer;

  const BeerCard({Key key, this.beer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new BeerCardState(beer);
  }
}

class BeerCardState extends State<BeerCard> {
  final Beer beer;

  final Map<BeerStatus, Color> beerStatusColorMap = {
    BeerStatus.LIKED: Colors.blue,
    BeerStatus.DISLIKED: Colors.red,
    BeerStatus.UNKNOWN: Colors.grey,
  };

  BeerStatus beerStatus = BeerStatus.UNKNOWN;
  Color likedColor;
  Color dislikedColor;

  BeerCardState(this.beer) {
    likedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
    dislikedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
  }

  @override
  void initState() {
    super.initState();

    queryForBeerStatus();
  }

  void queryForBeerStatus() {
    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((final DocumentSnapshot documentSnapshot) {
        setState(() {
          final List<String> likedBeers = new List<String>.from(documentSnapshot.data['likedBeers']);
          final List<String> dislikedBeers = new List<String>.from(documentSnapshot.data['dislikedBeers']);

          if (likedBeers.contains(beer.beerId)) {
            beerStatus = BeerStatus.LIKED;
            likedColor = beerStatusColorMap[this.beerStatus];
            dislikedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
          } else if (dislikedBeers.contains(beer.beerId)) {
            beerStatus = BeerStatus.DISLIKED;
            dislikedColor = beerStatusColorMap[this.beerStatus];
            likedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
          } else {
            dislikedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
            likedColor = beerStatusColorMap[BeerStatus.UNKNOWN];
          }
        });
      });
    });
  }

  void updateBeerStatus(final BeerStatus beerStatus) {
    if (beerStatus == this.beerStatus) {
      this.beerStatus = BeerStatus.UNKNOWN;
    } else {
      this.beerStatus = beerStatus;
    }

    FirebaseAuth.instance.currentUser().then((final FirebaseUser firebaseUser) {
      Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get()
          .then((final DocumentSnapshot documentSnapshot) {
        List<String> likedBeers = new List<String>.from(documentSnapshot.data['likedBeers']);
        List<String> dislikedBeers = new List<String>.from(documentSnapshot.data['dislikedBeers']);
        if (this.beerStatus == BeerStatus.LIKED) {
          dislikedBeers.remove(beer.beerId);
          likedBeers.add(beer.beerId);
        } else if (this.beerStatus == BeerStatus.DISLIKED) {
          likedBeers.remove(beer.beerId);
          dislikedBeers.add(beer.beerId);
        } else {
          likedBeers.remove(beer.beerId);
          dislikedBeers.remove(beer.beerId);
        }

        Firestore.instance.collection('users').document(firebaseUser.uid).updateData({
          'likedBeers': likedBeers,
          'dislikedBeers': dislikedBeers,
        }).then((_) {
          queryForBeerStatus();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.local_drink),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            title: new Text(beer.name.isNotEmpty ? beer.name : 'Unknown'),
            subtitle: new Text('${beer.brewerName != null ? '${beer.brewerName}\n' : ''}'
                '${beer.categoryName != null ? 'Category: ${beer.categoryName}\n' : ''}'
                '${beer.styleName != null ? 'Style: ${beer.styleName}' : ''}'),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.thumb_up),
                    color: likedColor,
                    onPressed: () {
                      updateBeerStatus(BeerStatus.LIKED);
                    }),
                new IconButton(
                    icon: new Icon(Icons.thumb_down),
                    color: dislikedColor,
                    onPressed: () {
                      updateBeerStatus(BeerStatus.DISLIKED);
                    }),
                new FlatButton(
                  child: const Text('More Info'),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (final BuildContext context) {
                        return new BeerInfoPage(beer: beer);
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
