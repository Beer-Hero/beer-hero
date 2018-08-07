import 'package:beer_hero/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget body;
  final String titleText;
  final FloatingActionButton floatingActionButton;
  final List<Widget> appBarActions;

  final TextStyle tileStyle = new TextStyle(fontSize: 17.0);

  GlobalScaffold({this.body, this.titleText = 'Beer Hero', this.floatingActionButton, this.appBarActions});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: floatingActionButton,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text(titleText),
        actions: appBarActions,
      ),
      drawer: new GlobalDrawer(),
      body: this.body,
    );
  }
}
