import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:flutter/material.dart';

class RentController {
  String selectedRentAccount = "1";
  String selectedMonth = "1";
  String selectedDay = "1";
  String selectedMonthUI = "1 mois";
  String selectedDayUI = "1 jours";
  TextEditingController price;
  String? selectedSuiteId;
  String? selectedTenantId;

  bool isRentWithWaranty = true;

  RentController() : price = TextEditingController();

  bool validate() =>
      price.text.isNotEmpty &&
      selectedSuiteId != null &&
      selectedTenantId != null;

  submit(AppBloc bloc) {
    Map<String, dynamic> data = {
      "appartementId": selectedSuiteId,
      "landlordId": selectedTenantId,
      "amount": double.parse(price.text.trim()),
      "month": int.parse(selectedMonth),
      "numberOfHabitant": int.parse(selectedRentAccount),
    };
    bloc.add(
      isRentWithWaranty
          ? CONFIGRENT(
              data: data,
            )
          : CONFIGRENTDAILY(
              data: {
                "appartementId": selectedSuiteId,
                "landlordId": selectedTenantId,
                "amount": double.parse(price.text.trim()),
                "days": int.parse(selectedDay),
                "numberOfHabitant": int.parse(selectedRentAccount),
              },
            ),
    );
  }
}
