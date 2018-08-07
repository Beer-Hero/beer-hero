import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:beer_hero/model/beer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewBeerForm extends StatefulWidget {
  @override
  State createState() {
    return new NewBeerFormState();
  }
}

class NewBeerFormState extends State<NewBeerForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController descriptionController = new TextEditingController();
  final TextEditingController abvController = new TextEditingController();
  final TextEditingController styleNameController = new TextEditingController();
  final TextEditingController categoryNameController = new TextEditingController();
  final TextEditingController breweryNameController = new TextEditingController();

  String barcodeText = '';

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).primaryTextTheme.title;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Required *',
            style: textStyle.copyWith(fontSize: 10.0),
          ),
          new TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Beer Name *', labelStyle: textStyle),
            style: textStyle,
            validator: (value) {
              if (value.isEmpty) {
                return 'A beer must have a name';
              }
            },
          ),
          new TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description', labelStyle: textStyle),
            style: textStyle,
            maxLines: 3,
          ),
          new TextFormField(
            controller: abvController,
            decoration: InputDecoration(labelText: 'Alcohol by Volume %', labelStyle: textStyle),
            style: textStyle,
            validator: (value) {
              if (value.isNotEmpty) {
                try {
                  double.parse(value);
                } catch (e) {
                  return 'Alcohol by volume must be a number';
                }
              }
            },
          ),
          new TextFormField(
            controller: styleNameController,
            decoration: InputDecoration(labelText: 'Style Name', labelStyle: textStyle),
            style: textStyle,
          ),
          new TextFormField(
            controller: categoryNameController,
            decoration: InputDecoration(labelText: 'Category Name', labelStyle: textStyle),
            style: textStyle,
          ),
          new TextFormField(
            controller: breweryNameController,
            decoration: InputDecoration(labelText: 'Brewery Name', labelStyle: textStyle),
            style: textStyle,
          ),
          new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
          _barcodeBar(textStyle),
          new Center(
            child: new Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: new FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                    _submit();
                    Navigator.pop(context);
                  }
                },
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text('Submit'),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
                    new Icon(Icons.send),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _barcodeBar(final TextStyle textStyle) {
    final List<Widget> widgets = [];

    if (barcodeText.isEmpty) {
      widgets.add(new FlatButton(
        onPressed: () {
          _scan();
        },
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text('Scan Barcode'),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
            new Icon(Icons.camera),
          ],
        ),
        color: textStyle.color,
      ));
    } else {
      widgets.add(new FlatButton(
        onPressed: () {
          setState(() {
            barcodeText = '';
          });
        },
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text('Clear'),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
            new Icon(Icons.clear),
          ],
        ),
        color: textStyle.color,
      ));
    }

    widgets.addAll([
      new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
      new Text(
        barcodeText,
        style: textStyle,
      )
    ]);

    return new Row(
      children: widgets,
    );
  }

  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        barcodeText = barcode;
      });
      print('Barcode set to [$barcode]');
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          barcodeText = 'The user did not grant the camera permission!';
        });
      } else {
        barcodeText = 'Unknown error: $e';
      }
    } on FormatException {
      barcodeText = 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      barcodeText = 'Unknown error: $e';
    }
  }

  Future _submit() {
    return Firestore.instance.collection('beers').add(new Beer(
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            abv: abvController.text.trim(),
            styleName: styleNameController.text.trim(),
            categoryName: categoryNameController.text.trim(),
            brewerName: breweryNameController.text.trim(),
            upc: barcodeText.trim())
        .toMap());
  }
}
