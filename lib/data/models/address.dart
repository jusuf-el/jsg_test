import 'package:jsg_test/data/models/geo_coordinates.dart';

class Address {
  String street = '';
  String suite = '';
  String city = '';
  String zipcode = '';
  String website = '';
  GeoCoordinates geo = GeoCoordinates();

  Address({
    this.street = '',
    this.suite = '',
    this.city = '',
    this.zipcode = '',
    this.website = '',
    geo,
  }) : geo = geo ?? GeoCoordinates();

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'] ?? '';
    suite = json['suite'] ?? '';
    city = json['city'] ?? '';
    zipcode = json['zipcode'] ?? '';
    website = json['website'] ?? '';
    geo = GeoCoordinates.fromJson(json['geo'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['website'] = website;
    data['geo'] = geo;
    return data;
  }
}
