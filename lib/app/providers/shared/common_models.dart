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
