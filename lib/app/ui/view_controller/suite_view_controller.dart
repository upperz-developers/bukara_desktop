import 'dart:convert';
import 'dart:io';

import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/shared/common_models.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/ui/view_controller/enterprise_view_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SuiteViewController {
  Map<String, dynamic> caracteristics = {
    "Cuisine": Iconsax.back_square,
    "Connxion internet": Iconsax.wifi,
    "Toilette interne": Iconsax.box_1,
    "Toillette externe": Iconsax.arrange_square_24,
    "Cash power": Iconsax.call_slash,
    "Snel": Iconsax.star,
    "Eau": Iconsax.ranking5,
    "Parking": Iconsax.car,
    "Piscine": Iconsax.bezier,
  };
  TextEditingController designation;
  TextEditingController description;
  TextEditingController price;
  AddressController addressController;
  List<String> selectedCaracteristics;
  String selectedGoods = getAppConfig().typeBiens!.first.designation!;
  String selectedSuite = getAppConfig().typeAppart!.first.designation!;
  String selectedCountBedRoom = "0";
  String selectedCountInternToilet = "0";
  String selectedCountExternToilet = "0";
  String selectedCountLeavingRoom = "0";
  String selectedSuiteNumber = "1";
  List<File> images;
  List<String> typeApparts;
  List<String> typebiens;
  SuiteViewController()
      : addressController = AddressController(),
        designation = TextEditingController(),
        description = TextEditingController(),
        price = TextEditingController(),
        selectedCaracteristics = [],
        images = [],
        typeApparts = [],
        typebiens = [] {
    for (TypeAppart typeAppart in getAppConfig().typeAppart!) {
      typeApparts.add(typeAppart.designation!);
    }
    for (TypeBiens typebien in getAppConfig().typeBiens!) {
      typebiens.add(typebien.designation!);
    }
  }

  bool validated() =>
      designation.text.trim().isNotEmpty &&
      description.text.trim().isNotEmpty &&
      price.text.trim().isNotEmpty &&
      images.length == 5 &&
      addressController.validated();

  void submit(BuildContext context) {
    Map<String, dynamic> caracteristic = {
      "bedroom": int.parse(selectedCountBedRoom),
      "interntoilet": int.parse(selectedCountInternToilet),
      "externtoilet": int.parse(selectedCountExternToilet),
      "livingroom": int.parse(selectedCountLeavingRoom),
      "other": selectedCaracteristics,
    };

    if (validated()) {
      String? typeBienId = getAppConfig()
          .typeBiens!
          .where((typebien) => typebien.designation == selectedGoods)
          .first
          .id;
      String? typeAppart = getAppConfig()
          .typeAppart!
          .where((typeAppart) => typeAppart.designation == selectedSuite)
          .first
          .id;

      Addresses suiteAdress = Addresses(
        city: addressController.city.text.trim(),
        town: addressController.town.text.trim(),
        country: addressController.country.text.trim(),
        quarter: addressController.quater.text.trim(),
        street: addressController.avenue.text.trim(),
        number: int.tryParse(addressController.number.text.trim()),
      );
      suiteAdress.toJson().removeWhere((key, value) => value == null);

      Map<String, dynamic> data = {
        "designation": designation.text.trim(),
        "typeBienId": typeBienId,
        "typeAppartementId": typeAppart,
        "description": description.text.trim(),
        "features": jsonEncode(caracteristic),
        "address": suiteAdress.toJson(),
        "number": selectedSuiteNumber,
        "price": double.tryParse(price.text.trim()),
      };

      List<String> imagePaths = [];
      for (File image in images) {
        imagePaths.add(image.path);
      }

      context.read<AppBloc>().add(
            ADDSUITE(
              data: data,
              imagePaths: imagePaths,
            ),
          );
    }
  }

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      if (images.length + files.length <= 5) {
        for (File f in files) {
          images.add(f);
        }
      } else {
        int length = 5 - images.length;
        for (int i = 0; i < length; i++) {
          images.add(files[i]);
        }
      }
    }
  }

  void dispose() {
    designation = description = price = TextEditingController();
    addressController.dispose();
  }
}
