import 'dart:convert';
import 'dart:io';
import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/shared/common_models.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/enterprise_view_controller.dart';
import 'package:bukara/app/ui/views/app/suite/add_suite.dart';
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
  File? changedImageAtIndex0,
      changedImageAtIndex1,
      changedImageAtIndex2,
      changedImageAtIndex3,
      changedImageAtIndex4;
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
  List<Map<String, dynamic>> editedImage;
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
        editedImage = [],
        typebiens = [] {
    for (TypeAppart typeAppart in getAppConfig().typeAppart!) {
      typeApparts.add(typeAppart.designation!);
    }
    for (TypeBiens typebien in getAppConfig().typeBiens!) {
      typebiens.add(typebien.designation!);
    }
  }

  bool validated(BuildContext context) {
    if (isSuiteEdit != true && images.length < 5) {
      alertInfo(
        context,
        action: "Quitter",
        onTap: () {
          Navigator.pop(context);
        },
        body:
            "Les images ne doivent pas etre nulle et doivent etre au nombre de cinq",
        head: "Image",
      );
      return false;
    }
    if (isSuiteEdit == true &&
        suiteToEdit!.images!.isEmpty &&
        images.isNotEmpty &&
        images.length < 5) {
      alertInfo(
        context,
        action: "Quitter",
        onTap: () {
          Navigator.pop(context);
        },
        body: "Les images doivent etre au nombre de cinq",
        head: "Image",
      );
      return false;
    }

    return designation.text.trim().isNotEmpty &&
            description.text.trim().isNotEmpty &&
            price.text.trim().isNotEmpty &&
            addressController.validated() ||
        isSuiteEdit == true;
  }

  void submit(BuildContext context) {
    Map<String, dynamic> caracteristic = {
      "bedroom": int.parse(selectedCountBedRoom),
      "interntoilet": int.parse(selectedCountInternToilet),
      "externtoilet": int.parse(selectedCountExternToilet),
      "livingroom": int.parse(selectedCountLeavingRoom),
      "other": selectedCaracteristics,
    };

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
      city: isSuiteEdit == true && addressController.city.text.trim().isEmpty
          ? suiteToEdit!.address!.city
          : addressController.city.text.trim(),
      town: isSuiteEdit == true && addressController.town.text.trim().isEmpty
          ? suiteToEdit!.address!.town
          : addressController.town.text.trim(),
      country:
          isSuiteEdit == true && addressController.country.text.trim().isEmpty
              ? suiteToEdit!.address!.country
              : addressController.country.text.trim(),
      quarter:
          isSuiteEdit == true && addressController.quater.text.trim().isEmpty
              ? suiteToEdit!.address!.quarter
              : addressController.quater.text.trim(),
      street:
          isSuiteEdit == true && addressController.avenue.text.trim().isEmpty
              ? suiteToEdit!.address!.city
              : addressController.avenue.text.trim(),
      number:
          isSuiteEdit == true && addressController.number.text.trim().isEmpty
              ? suiteToEdit!.address!.number
              : int.tryParse(addressController.number.text.trim()),
      common:
          isSuiteEdit == true && addressController.commune.text.trim().isEmpty
              ? suiteToEdit!.address!.common
              : addressController.commune.text.trim(),
    );

    suiteAdress.toJson().removeWhere((key, value) => value == null);

    Map<String, dynamic> data = {
      "designation": isSuiteEdit == true && designation.text.trim().isEmpty
          ? suiteToEdit!.designation
          : designation.text.trim(),
      "typeBienId": typeBienId,
      "typeAppartementId": typeAppart,
      "description": isSuiteEdit == true && description.text.trim().isEmpty
          ? suiteToEdit!.description
          : description.text.trim(),
      "features": jsonEncode(caracteristic),
      "address": suiteAdress.toJson(),
      "number": selectedSuiteNumber == "0" ? "1" : selectedSuiteNumber,
      "price": isSuiteEdit == true && price.text.trim().isEmpty
          ? suiteToEdit!.price
          : double.tryParse(price.text.trim()),
    };

    List<String> imagePaths = [];
    for (File image in images) {
      imagePaths.add(image.path);
    }

    context.read<AppBloc>().add(
          isSuiteEdit == true
              ? EDITSUITE(
                  data: data,
                  editedImage: editedImage,
                  imagePaths: imagePaths,
                  appartId: suiteToEdit!.id,
                  address: suiteAdress.toJson(),
                )
              : ADDSUITE(
                  data: data,
                  imagePaths: imagePaths,
                ),
        );
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

  Future<void> pickOneImage({String? imageId, required int? index}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      editedImage.add({"imageId": imageId, "filePath": files.first.path});
      switch (index) {
        case 0:
          changedImageAtIndex0 = files.first;
          break;
        case 1:
          changedImageAtIndex1 = files.first;
          break;
        case 2:
          changedImageAtIndex2 = files.first;
          break;
        case 3:
          changedImageAtIndex3 = files.first;
          break;
        default:
          changedImageAtIndex4 = files.first;
      }
    }
  }

  void dispose() {
    designation = description = price = TextEditingController();
    addressController.dispose();
  }
}
