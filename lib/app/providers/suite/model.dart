import 'dart:convert';

import 'package:bukara/app/providers/shared/common_models.dart';
import 'package:bukara/app/providers/user/user.dart';

class ResultSuite {
  bool? status;
  Data? data;

  ResultSuite({this.status, this.data});

  ResultSuite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Suite>? suites;

  Data({this.suites});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      suites = <Suite>[];
      json['data'].forEach((v) {
        suites!.add(Suite.fromJson(v));
      });
    }
  }
}

class Suite {
  String? id;
  TypeBiens? typeBien;
  TypeAppart? typeAppartement;
  int? number;
  String? description;
  String? designation;
  SuiteFeature? features;
  bool? status;
  int? price;
  String? createdAt;
  String? updatedAt;
  Addresses? address;
  List<Image>? images;

  Suite({
    this.id,
    this.typeBien,
    this.typeAppartement,
    this.number,
    this.description,
    this.features,
    this.status,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.images,
    this.designation,
  });

  Suite.fromJson(Map<String, dynamic> json) {
    images = [];
    id = json['id'];
    typeBien =
        json['typeBien'] != null ? TypeBiens.fromJson(json['typeBien']) : null;
    typeAppartement = json['typeAppartement'] != null
        ? TypeAppart.fromJson(json['typeAppartement'])
        : null;
    number = json['number'];
    description = json['description'];
    if (json['features'] != null) {
      Map<String, dynamic> data = jsonDecode(json['features']);
      features = SuiteFeature.fromJson(data);
    }
    designation = json['designation'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address =
        json['address'] != null ? Addresses.fromJson(json['address']) : null;
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((img) {
        images!.add(Image.fromJson(img));
      });
    }
  }
}

// {bedroom: 4, interntoilet: 3, externtoilet: 1, livingroom: 1, other: [cuisine, toilette externe, cash power, toilette interne, courant normal, Piscine]}
class SuiteFeature {
  int? bedroom;
  int? interntoilet;
  int? externtoilet;
  int? livingroom;
  List<String>? other;
  SuiteFeature(
      {this.bedroom,
      this.externtoilet,
      this.interntoilet,
      this.livingroom,
      this.other});

  SuiteFeature.fromJson(Map<String, dynamic> json) : other = [] {
    bedroom = json['bedroom'];
    interntoilet = json['interntoilet'];
    externtoilet = json['externtoilet'];
    livingroom = json['externtoilet'];
    livingroom = json['livingroom'];
    if (json['other'] != null) {
      json['other'].forEach((car) {
        other!.add(car);
      });
    }
  }
}
