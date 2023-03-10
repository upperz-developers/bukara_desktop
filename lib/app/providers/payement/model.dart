import 'package:bukara/app/providers/recovery/model.dart';

class ResultHistoricPaiements {
  bool? status;
  RecoveryData? data;

  ResultHistoricPaiements({this.status, this.data});

  ResultHistoricPaiements.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? RecoveryData.fromJson(json['data']) : null;
  }
}

class RecoveryData {
  Meta? meta;
  List<PayementHistoric>? payments;

  RecoveryData({this.meta, this.payments});

  RecoveryData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      payments = <PayementHistoric>[];
      json['data'].forEach((p) {
        payments!.add(PayementHistoric.fromJson(p));
      });
    }
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? previousPageUrl;

  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    firstPage = json['first_page'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }
}

class PayementHistoric {
  String? id;
  ContratData? contratData;
  String? type;
  User? createdBy;
  String? transactionId;
  double? amount;
  double? amountDue;
  double? amountPay;
  double? leftToPay;
  String? currenty;
  bool? status;
  String? createdAt;
  String? updatedAt;

  PayementHistoric({
    this.id,
    this.contratData,
    this.type,
    this.transactionId,
    this.amount,
    this.currenty,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.leftToPay,
    this.amountDue,
  });

  PayementHistoric.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contratData = json['recovery'] != null
        ? ContratData.fromJson(json['recovery'])
        : null;
    createdBy =
        json['created_by'] != null ? User.fromJson(json['created_by']) : null;
    type = json['type'];
    transactionId = json['transaction_id'];

    amountPay = json['amount_pay'] != null
        ? double.parse(json['amount_pay'].toString())
        : null;
    leftToPay = json['left_to_pay'] != null
        ? double.parse(json['left_to_pay'].toString())
        : null;
    amount =
        json['amount'] != null ? double.parse(json['amount'].toString()) : null;
    amountDue = json['amount_due'] != null
        ? double.parse(json['amount_due'].toString())
        : null;
    currenty = json['currenty'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy =
        json['created_by'] != null && json['created_by'].runtimeType != String
            ? User.fromJson(json['created_by'])
            : null;
  }
}
