import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:flutter/material.dart';

class PaiementController {
  TextEditingController amount;
  TextEditingController transId;
  String? recoveryId;
  String selectedPaiementType = "cash";
  List<String> typePaiement = ['cash', 'bank'];

  PaiementController()
      : amount = TextEditingController(),
        transId = TextEditingController();

  submit(AppBloc bloc) {
    var data = {
      "recovery_id": recoveryId,
      "type": selectedPaiementType,
      "amount": double.tryParse(amount.text.trim()),
    };
    if (selectedPaiementType == 'bank') {
      data['transactionId'] = transId.text.trim();
    }
    bloc.add(PAYERENT(data: data));
  }

  bool validation() {
    bool validationType = true;
    if (selectedPaiementType == 'bank') {
      validationType = transId.text.isNotEmpty;
    }

    return amount.text.isNotEmpty && validationType;
  }
}
