// ready for first testss

class Addresses {
  String? id;
  String? entrepriseId;
  String? country;
  String? town;
  String? reference;
  String? city;
  String? quarter;
  String? street;
  int? number;
  String? createdAt;
  String? updatedAt;
  String? common;

  Addresses(
      {this.id,
      this.entrepriseId,
      this.country,
      this.town,
      this.city,
      this.quarter,
      this.street,
      this.number,
      this.createdAt,
      this.reference,
      this.common,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    common = json['common'];
    entrepriseId = json['entreprise_id'];
    country = json['country'];
    town = json['town'];
    city = json['city'];
    quarter = json['quarter'];
    street = json['street'];
    number = json['number'];
    reference = json['reference'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['entreprise_id'] = entrepriseId;
    data['country'] = country;
    data['common'] = common;
    data['town'] = town;
    data['reference'] = reference;
    data['city'] = city;
    data['quarter'] = quarter;
    data['street'] = street;
    data['number'] = number;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Image {
  String? id;
  String? url;
  String? createdAt;
  String? updatedAt;

  Image({this.id, this.url, this.createdAt, this.updatedAt});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Phones {
  String? id;
  String? personneId;
  String? countryCode;
  String? number;
  String? createdAt;
  String? updatedAt;

  Phones(
      {this.id,
      this.personneId,
      this.countryCode,
      this.number,
      this.createdAt,
      this.updatedAt});

  Phones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personneId = json['personne_id'];
    countryCode = json['country_code'];
    number = json['number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ErrorModel {
  List<ErrorData>? errors;

  ErrorModel() : errors = [];

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errors = [];
    if (json['errors'] != null) {
      errors = <ErrorData>[];
      json['errors'].forEach((v) {
        errors!.add(ErrorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorData {
  String? rule;
  String? field;
  String? message;

  ErrorData({this.rule, this.field, this.message});

  ErrorData.fromJson(Map<String, dynamic> json) {
    rule = json['rule'];
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() => {
        "rule": rule,
        "field": field,
        "message": message,
      };
}
