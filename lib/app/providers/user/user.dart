class UserResult {
  bool? status;
  Token? token;
  User? user;

  UserResult({this.status, this.token, this.user});

  UserResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class Token {
  String? type;
  String? token;

  Token({this.type, this.token});

  Token.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
      };
}

class User {
  String? id;
  String? name;
  String? lastname;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? profile;
  bool? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.lastname,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.profile,
      this.status,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    profile = json['profile'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
