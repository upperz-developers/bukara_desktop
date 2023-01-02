import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/shared/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterpriseController {
  TextEditingController designation;
  TextEditingController rccm;
  TextEditingController idnat;
  TextEditingController impot;
  TextEditingController description;
  AddressController addressController;
  BankController bankController;
  ContactController contactController;

  EnterpriseController()
      : designation = TextEditingController(),
        rccm = TextEditingController(),
        idnat = TextEditingController(),
        impot = TextEditingController(),
        description = TextEditingController(),
        addressController = AddressController(),
        bankController = BankController(),
        contactController = ContactController();

  bool validated() =>
      designation.text.trim().isNotEmpty &&
      rccm.text.trim().isNotEmpty &&
      idnat.text.trim().isNotEmpty &&
      impot.text.trim().isNotEmpty &&
      addressController.validated() &&
      contactController.validated() &&
      bankController.validated();

  void submit(BuildContext context) {
    Enterprise enterprise = Enterprise(
      description: description.text.trim(),
      designation: designation.text.trim(),
      rccm: rccm.text.trim(),
    );

    Addresses addresse = Addresses(
      city: addressController.city.text.trim(),
      country: addressController.country.text.trim(),
      quarter: addressController.quater.text.trim(),
      town: addressController.town.text.trim(),
      street: addressController.avenue.text.trim(),
      number: int.parse(addressController.number.text.trim()),
    );

    Banks bank = Banks(
      accountName: bankController.accounName.text.trim(),
      accountNumber: bankController.accountNumber.text.trim(),
      bank: bankController.bankName.text.trim(),
    );

    enterprise.addresses!.add(addresse);
    enterprise.banks!.add(bank);
    context.read<AppBloc>().add(
          ADDENTERPRISE(
            enterprise: enterprise,
          ),
        );
  }

  void dispose() {
    designation = rccm = idnat = impot = description = TextEditingController();
    addressController.dispose();
    bankController.dispose();
    contactController.dispose();
  }
}

class AddressController {
  TextEditingController reference;
  TextEditingController country;
  TextEditingController city;
  TextEditingController town;
  TextEditingController commune;
  TextEditingController quater;
  TextEditingController avenue;
  TextEditingController number;

  AddressController()
      : reference = TextEditingController(),
        country = TextEditingController(text: "Congo/kinshasa"),
        city = TextEditingController(text: "Nord-kivu"),
        town = TextEditingController(text: "Goma"),
        commune = TextEditingController(),
        quater = TextEditingController(),
        avenue = TextEditingController(),
        number = TextEditingController();

  bool validated() {
    bool isValidate = country.text.trim().isNotEmpty &&
        city.text.trim().isNotEmpty &&
        town.text.trim().isNotEmpty &&
        commune.text.trim().isNotEmpty &&
        quater.text.trim().isNotEmpty &&
        avenue.text.trim().isNotEmpty &&
        number.text.trim().isNotEmpty;
    return isValidate;
  }

  dispose() {
    reference = country = city =
        town = commune = quater = avenue = number = TextEditingController();
  }
}

class ContactController {
  String code;
  TextEditingController phoneNumber;
  TextEditingController email;
  TextEditingController internet;

  ContactController()
      : code = "+243",
        phoneNumber = TextEditingController(),
        email = TextEditingController(),
        internet = TextEditingController();

  bool validated() {
    return phoneNumber.text.trim().isNotEmpty &&
        email.text.trim().isNotEmpty &&
        internet.text.trim().isNotEmpty;
  }

  dispose() {
    phoneNumber = email = internet = TextEditingController();
    code = "+243";
  }
}

class BankController {
  TextEditingController accountNumber;
  TextEditingController accounName;
  TextEditingController bankName;

  BankController()
      : accounName = TextEditingController(),
        accountNumber = TextEditingController(),
        bankName = TextEditingController();

  bool validated() =>
      accounName.text.trim().isNotEmpty &&
      accountNumber.text.trim().isNotEmpty &&
      bankName.text.trim().isNotEmpty;

  void dispose() {
    accounName = accountNumber = bankName = TextEditingController();
  }
}
