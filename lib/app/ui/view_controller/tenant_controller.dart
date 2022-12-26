import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:flutter/material.dart';

class TenantController {
  List<String> cartType = ["carte electeur", "passport", "permis"];
  List<String> tenantType = ["Personne physique", "Personne morale"];
  String selectedCardType = "carte electeur";
  String countryCode = "+243";
  TextEditingController? firstName;
  TextEditingController? lastname;
  TextEditingController? email;
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
  }

  void submit(AppBloc bloc) {
    List<Map<String, dynamic>> phones = [];
    phones
        .add({"country_code": countryCode, "number": phoneNumber!.text.trim()});

    Map<String, dynamic> data = {
      "name": firstName!.text.trim(),
      "lastname": lastname!.text.trim(),
      "email": email!.text.trim(),
      "cardType": selectedCardType,
      "cardTypeId": cartId!.text.trim(),
      "phones": phones,
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
