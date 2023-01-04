import 'package:bukara/app/providers/shared/common_models.dart';

class ResultEnterprise {
  bool? status;
  Enterprise? data;

  ResultEnterprise({this.status, this.data});

  ResultEnterprise.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Enterprise.fromJson(json['data']) : null;
  }
}

class Enterprise {
  String? id;
  String? designation;
  String? description;
  String? rccm;
  String? logo;
  String? idnat;
  String? impot;
  String? createdAt;
  String? updatedAt;
  List<Addresses>? addresses;
  List<Banks>? banks;

  Enterprise({
    this.id,
    this.designation,
    this.description,
    this.rccm,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.idnat,
    this.impot,
  })  : addresses = [],
        banks = [];

  Enterprise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    description = json['description'];
    rccm = json['rccm'];
    logo = json['logo'];
    idnat = json['idnat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(
          Addresses.fromJson(v),
        );
      });
    }
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['designation'] = designation;
    data['description'] = description;
    data['rccm'] = rccm;
    data['idnat'] = idnat;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (banks != null) {
      data['bank_accounts'] = banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String? id;
  String? entrepriseId;
  String? bank;
  String? accountName;
  String? accountNumber;
  String? createdAt;
  String? updatedAt;

  Banks(
      {this.id,
      this.entrepriseId,
      this.bank,
      this.accountName,
      this.accountNumber,
      this.createdAt,
      this.updatedAt});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entrepriseId = json['entreprise_id'];
    bank = json['bank'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['entreprise_id'] = entrepriseId;
    data['bank'] = bank;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
