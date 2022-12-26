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
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
