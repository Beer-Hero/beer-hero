import 'package:cloud_firestore/cloud_firestore.dart';

enum BeerStatus { LIKED, DISLIKED, UNKNOWN }

class Beer {
  final String beerId;
  final String brewerId;
  final String brewerName;
  final String name;
  final String categoryId;
  final String categoryName;
  final String styleId;
  final String styleName;
  final String description;
  final dynamic abv;
  final dynamic ibu;
  final List<String> tags;
  final String upc;

  Beer(
      {this.beerId,
      this.brewerId,
      this.brewerName,
      this.name,
      this.categoryId,
      this.categoryName,
      this.styleId,
      this.styleName,
      this.description,
      this.abv,
      this.ibu,
      this.tags,
      this.upc});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beerId': beerId,
      'breweryId': brewerId,
      'breweryName': brewerName,
      'name': name,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'styleId': styleId,
      'styleName': styleName,
      'description': description,
      'abv': abv,
      'ibu': ibu,
      'tags': tags,
      'upc': upc,
    };
  }

  static Beer fromMap(final String beerId, final Map<String, dynamic> data) {
    return new Beer(
        beerId: beerId,
        brewerId: _normalizeDataToString(data['breweryId']),
        brewerName: _normalizeDataToString(data['breweryName']),
        name: _normalizeDataToString(data['name']),
        categoryId: _normalizeDataToString(data['categoryId']),
        categoryName: _normalizeDataToString(data['categoryName']),
        styleId: _normalizeDataToString(data['styleId']),
        styleName: _normalizeDataToString(data['styleName']),
        description: _normalizeDataToString(data['description']),
        abv: data['abv'],
        ibu: data['ibu'],
        tags: new List<String>.from(data['tags'] != null ? data['tags'] : []),
        upc: data['upc']);
  }

  static Beer fromDocumentSnapshot(final DocumentSnapshot documentSnapshot) {
    return Beer.fromMap(documentSnapshot.documentID, documentSnapshot.data);
  }

  static String _normalizeDataToString(final dynamic data) {
    if (data is String) {
      final String trimmed = data.trim();
      if (trimmed.isNotEmpty) {
        return trimmed;
      }
    }

    return null;
  }
}
