import 'dart:io';

import 'package:bukara/app/ui/view_controller/enterprise_view_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SuiteViewController {
  Map<String, dynamic> caracteristics = {
    "cuisine": Iconsax.back_square,
    "connexion": Iconsax.wifi,
    "toilette interne": Iconsax.box_1,
    "toilette externe": Iconsax.arrange_square_24,
    "cash power": Iconsax.call_slash,
    "courant normal": Iconsax.star,
    "eau": Iconsax.ranking5,
    "parking": Iconsax.car,
    "Piscine": Iconsax.bezier,
  };
  TextEditingController designation;
  TextEditingController description;
  TextEditingController price;
  AddressController addressController;
  List<String> selectedCaracteristics;
  List<File> images;
  SuiteViewController()
      : addressController = AddressController(),
        designation = TextEditingController(),
        description = TextEditingController(),
        price = TextEditingController(),
        selectedCaracteristics = [],
        images = [];

  bool validated() =>
      designation.text.trim().isNotEmpty &&
      description.text.trim().isNotEmpty &&
      price.text.trim().isNotEmpty &&
      addressController.validated();

  void submit() {}

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
