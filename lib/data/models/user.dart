import 'package:jsg_test/data/models/address.dart';
import 'package:jsg_test/data/models/company.dart';

class User {
  int? id;
  String name = '';
  String username = '';
  String email = '';
  String phone = '';
  String website = '';
  Address address = Address();
  Company company = Company();

  User({
    this.id,
    this.name = '',
    this.username = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    address,
    company,
  })  : address = address ?? Address(),
        company = company ?? Company();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    website = json['website'] ?? '';
    address = Address.fromJson(json['address'] ?? {});
    company = Company.fromJson(json['company'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['website'] = website;
    data['address'] = address;
    data['company'] = company;
    return data;
  }
}
