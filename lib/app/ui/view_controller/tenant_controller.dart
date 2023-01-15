import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/ui/views/app/tenant/add_tenant.dart';
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

  void submit({AppBloc? bloc, bool? isEdit, TenantModel? tenant}) {
    List<Map<String, dynamic>> phones = [];
    phones.add({
      "countryCode": isEdit == true && countryCode == "+243"
          ? tenant!.phones![0].countryCode
          : countryCode,
      "number": isEdit == true && phoneNumber!.text.trim().isEmpty
          ? tenant!.phones![0].number
          : phoneNumber!.text.trim(),
      "running": true
    });

    Map<String, dynamic> data = {
      "name": isEdit == true && firstName!.text.trim().isEmpty
          ? tenant!.name
          : firstName!.text.trim(),
      "lastname": isEdit == true && lastname!.text.trim().isEmpty
          ? tenant!.lastname
          : lastname!.text.trim(),
      "email": isEdit == true && email!.text.trim().isEmpty
          ? tenant!.email
          : email!.text.trim(),
      "landlordType": selectedTenantType,
      "cardType": selectedCardType,
      "lastAdress": isEdit == true && lastAddress!.text.trim().isEmpty
          ? tenant!.landlordType
          : lastAddress!.text.trim(),
      "cardTypeId": isEdit == true && cartId!.text.trim().isEmpty
          ? null
          : cartId!.text.trim(),
      "maritalStatus": selectedTenantCivilState,
      "phones": phones,
      "nationality": isEdit == true && nationalite!.text.trim().isEmpty
          ? tenant!.nationality
          : nationalite!.text.trim(),
    };
    data.removeWhere((key, value) => value == null);
    bloc!.add(
      isEditTenant == true
          ? EDDITTENANT(
              phone: phones.first,
              tenantId: tenant!.id,
              data: data,
              phoneId: tenant.phones![0].id,
            )
          : ADDTENANT(data: data),
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
