import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:beer_hero/widgets/trending_feed.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GlobalScaffold(
      titleText: 'Trending',
      body: new TrendingFeed(),
    );
  }
}
