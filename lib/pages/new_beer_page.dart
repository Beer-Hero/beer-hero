import 'package:beer_hero/widgets/global_scaffold.dart';
import 'package:beer_hero/widgets/new_beer_form.dart';
import 'package:flutter/material.dart';

class NewBeerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GlobalScaffold(
        titleText: 'Add A New Beer',
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new ListView(
            children: <Widget>[
              new NewBeerForm(),
            ],
          ),
        ));
  }
}
