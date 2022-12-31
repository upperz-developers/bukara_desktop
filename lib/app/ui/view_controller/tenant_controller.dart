import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:flutter/material.dart';

class TenantController {
  List<String> cartType = ["carte electeur", "passport", "permis"];
  List<String> tenantType = ["personne physique", "entreprise"];
  List<String> tenantCivilState = ["married", "single"];
  String selectedCardType = "carte electeur";
  String countryCode = "+243";
  String selectedTenantType = "personne physique";
  String selectedTenantCivilState = "married";
  TextEditingController? firstName;
  TextEditingController? lastname;
  TextEditingController? email;
  TextEditingController? lastAddress;
  TextEditingController? cartId;
  TextEditingController? nationalite;
  TextEditingController? phoneNumber;

  TenantController() {
    firstName = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    cartId = TextEditingController();
    nationalite = TextEditingController();
    phoneNumber = TextEditingController();
    lastAddress = TextEditingController();
  }

  void submit(AppBloc bloc) {
    List<Map<String, dynamic>> phones = [];
    phones.add({
      "countryCode": countryCode,
      "number": phoneNumber!.text.trim(),
      "running": true
    });

    Map<String, dynamic> data = {
      "name": firstName!.text.trim(),
      "lastname": lastname!.text.trim(),
      "email": email!.text.trim(),
      "landlordType": selectedTenantType,
      "cardType": selectedCardType,
      "lastAdress": lastAddress!.text.trim(),
      "cardTypeId": cartId!.text.trim(),
      "maritalStatus": selectedTenantCivilState,
      "phones": phones,
      "nationality": nationalite!.text.trim(),
    };
    bloc.add(
      ADDTENANT(data: data),
    );
  }

  bool addValidation() =>
      firstName!.text.trim().isNotEmpty &&
      lastname!.text.trim().isNotEmpty &&
      email!.text.trim().isNotEmpty &&
      cartId!.text.trim().isNotEmpty &&
      nationalite!.text.trim().isNotEmpty &&
      phoneNumber!.text.trim().isNotEmpty;
}
