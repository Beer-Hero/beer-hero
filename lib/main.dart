import 'package:beer_hero/pages/home_page.dart';
import 'package:beer_hero/pages/splash_page.dart';
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
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new HomePage(),
      },
    );
  }
}
