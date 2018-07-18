import 'package:beer_hero/pages/about_page.dart';
import 'package:beer_hero/pages/discover_page.dart';
import 'package:beer_hero/pages/recommendations_page.dart';
import 'package:beer_hero/pages/splash_page.dart';
import 'package:beer_hero/pages/trending_page.dart';
import 'package:beer_hero/pages/your_beers_page.dart';
import 'package:beer_hero/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Beer Hero',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        TRENDING: (BuildContext context) => new TrendingPage(),
        RECOMMENDATIONS: (BuildContext context) => new RecommendationsPage(),
        DISCOVER: (BuildContext context) => new DiscoverPage(),
        YOUR_BEERS: (BuildContext context) => new YourBeersPage(),
        ABOUT: (BuildContext context) => new AboutPage(),
      },
    );
  }
}
