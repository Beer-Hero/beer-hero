import 'package:cloud_firestore/cloud_firestore.dart';

class Brewer {
  final String brewerId;
  final String name;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String website;

  Brewer({
    this.brewerId,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.website,
  });

  static Brewer fromMap(final String brewerId, final Map<String, dynamic> data) {
    return new Brewer(
      brewerId: brewerId,
      name: _normalizeDataToString(data['name']),
      address1: _normalizeDataToString(data['address1']),
      address2: _normalizeDataToString(data['address2']),
      city: _normalizeDataToString(data['city']),
      state: _normalizeDataToString(data['state']),
      country: _normalizeDataToString(data['country']),
      website: _normalizeDataToString(data['website']),
    );
  }

  static Brewer fromDocumentSnapshot(final DocumentSnapshot documentSnapshot) {
    return Brewer.fromMap(documentSnapshot.documentID, documentSnapshot.data);
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
