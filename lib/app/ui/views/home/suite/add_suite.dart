import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/ui/view_controller/suite_view_controller.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class AddSuite extends StatefulWidget {
  final ValueNotifier<bool> showSuites;
  const AddSuite({super.key, required this.showSuites});

  @override
  State<AddSuite> createState() => _AddSuiteState();
}

class _AddSuiteState extends State<AddSuite> {
  SuiteViewController suiteViewController = SuiteViewController();

  removeImage(int index) {
    setState(() {
      suiteViewController.images.removeAt(index);
    });
  }

  List<String> caracteristiqueKey = [];
  List<IconData> caracteristiqueValue = [];

  bool disabled = false;
  suiteCaracteristiqueModel() {
    suiteViewController.caracteristics.forEach((key, value) {
      caracteristiqueKey.add(key);
      caracteristiqueValue.add(value);
    });
    return caracteristic;
  }

  @override
  void initState() {
    suiteCaracteristiqueModel();
    super.initState();
  }

  bool submitted = false;
  void saveSuite() {
    setState(() {
      submitted = true;
    });
    if (suiteViewController.validated()) {
      suiteViewController.submit(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalSpace,
          right: horizontalSpace,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightBox,
                    Text(
                      "Ajouter un appartement",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.heightBox,
                    addImage(),
                    30.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 50,
                        children: [
                          aboutSuite(),
                          address(),
                          caracteristic(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Adresse",
        ),
        modelInfo(
          title: "Pays",
          hint: "Rep dem du congo",
          controller: suiteViewController.addressController.country,
        ),
        modelInfo(
          title: "Province",
          hint: "Nord-kivu",
          controller: suiteViewController.addressController.city,
        ),
        modelInfo(
          title: "Ville",
          hint: "Goma",
          controller: suiteViewController.addressController.town,
        ),
        modelInfo(
          title: "Commune",
          hint: "Goma",
          controller: suiteViewController.addressController.commune,
        ),
        modelInfo(
          title: "Quartier",
          hint: "Entrer le cartier",
          controller: suiteViewController.addressController.quater,
        ),
        modelInfo(
          title: "Avenue",
          hint: "Entrer l'avenu",
          controller: suiteViewController.addressController.avenue,
        ),
        modelInfo(
          title: "Numero",
          hint: "Entrer le numero",
          controller: suiteViewController.addressController.number,
        ),
      ],
    );
  }

  Widget addImage() {
    return Row(
      children: [
        Expanded(
          child: OnHoverEffect(
            child: suiteViewController.images.isNotEmpty
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: SizedBox(
                          height: 448,
                          width: 620,
                          child: Image.file(
                            suiteViewController.images[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: OnHoverEffect(
                          child: InkWell(
                            onTap: () {
                              removeImage(0);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.WHITE_COLOR.withOpacity(.7),
                              ),
                              child: const Icon(
                                Iconsax.gallery_remove,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      suiteViewController.pickImages().then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 448,
                      width: 600,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.image5,
                            size: 40,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                          10.heightBox,
                          Text(
                            "Cliquer sur une des cases\npour ajouter une image plusieurs images",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: AppColors.SECOND_TEXT_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
        8.widthBox,
        Column(
          children: [
            Row(
              children: [
                OnHoverEffect(
                  child: suiteViewController.images.length > 1
                      ? Stack(
                          children: [
                            ClipRRect(
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  suiteViewController.images[1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: OnHoverEffect(
                                child: InkWell(
                                  onTap: () {
                                    removeImage(1);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          AppColors.WHITE_COLOR.withOpacity(.7),
                                    ),
                                    child: const Icon(
                                      Iconsax.gallery_remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            suiteViewController.pickImages().then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: AppColors.SECOND_CARD_COLOR,
                            ),
                          ),
                        ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: suiteViewController.images.length > 2
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  suiteViewController.images[2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: OnHoverEffect(
                                child: InkWell(
                                  onTap: () {
                                    removeImage(2);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          AppColors.WHITE_COLOR.withOpacity(.7),
                                    ),
                                    child: const Icon(
                                      Iconsax.gallery_remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            suiteViewController.pickImages().then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: AppColors.SECOND_CARD_COLOR,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                OnHoverEffect(
                  child: suiteViewController.images.length > 3
                      ? Stack(
                          children: [
                            ClipRRect(
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  suiteViewController.images[3],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: OnHoverEffect(
                                child: InkWell(
                                  onTap: () {
                                    removeImage(3);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          AppColors.WHITE_COLOR.withOpacity(.7),
                                    ),
                                    child: const Icon(
                                      Iconsax.gallery_remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            suiteViewController.pickImages().then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: AppColors.SECOND_CARD_COLOR,
                            ),
                          ),
                        ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: suiteViewController.images.length > 4
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  suiteViewController.images[4],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: OnHoverEffect(
                                child: InkWell(
                                  onTap: () {
                                    removeImage(4);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          AppColors.WHITE_COLOR.withOpacity(.7),
                                    ),
                                    child: const Icon(
                                      Iconsax.gallery_remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            suiteViewController.pickImages().then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: AppColors.SECOND_CARD_COLOR,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget aboutSuite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Appartement",
        ),
        modelInfo(
          title: "Designation",
          hint: "Designation de l'entreprise",
          controller: suiteViewController.designation,
        ),
        modelInfo(
          title: "Prix",
          hint: "1 USD",
          controller: suiteViewController.price,
        ),
        Text(
          "Description",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.SECOND_TEXT_COLOR,
            ),
          ),
        ),
        8.heightBox,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 250,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: suiteViewController.description.text.isEmpty &&
                      submitted == true
                  ? 1.5
                  : 1,
              color: suiteViewController.description.text.isEmpty &&
                      submitted == true
                  ? AppColors.RED_COLOR
                  : AppColors.BORDER_COLOR,
            ),
          ),
          child: TextField(
            style: GoogleFonts.montserrat(
              fontSize: 12,
            ),
            controller: suiteViewController.description,
            maxLines: 3,
            maxLength: 125,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: "Description de l'entreprise",
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#numero",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: suiteViewController.selectedSuiteNumber,
                          borderRadius: BorderRadius.circular(4),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          underline: Container(),
                          isDense: true,
                          items: List.generate(100, (index) => "$index")
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 30,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedSuiteNumber =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.widthBox,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chambre",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: suiteViewController.selectedCountBedRoom,
                          borderRadius: BorderRadius.circular(4),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          underline: Container(),
                          isDense: true,
                          items: List.generate(10, (index) => "$index")
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 30,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedCountBedRoom =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.widthBox,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salon",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isDense: true,
                          underline: Container(),
                          value: suiteViewController.selectedCountLeavingRoom,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          items: List.generate(5, (index) => "$index")
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 30,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedCountLeavingRoom =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toillettes inter.",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: suiteViewController.selectedCountInternToilet,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          underline: Container(),
                          isDense: true,
                          items: List.generate(10, (index) => "$index")
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 74,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedCountInternToilet =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.widthBox,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toillettes ext.",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isDense: true,
                          underline: Container(),
                          value: suiteViewController.selectedCountExternToilet,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          items: List.generate(10, (index) => "$index")
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 74,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedCountExternToilet =
                                  newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type meuble",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: suiteViewController.selectedSuite,
                          borderRadius: BorderRadius.circular(4),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          underline: Container(),
                          isDense: true,
                          items: suiteViewController.typeApparts
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 74,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedSuite = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.widthBox,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type bien",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.SECOND_TEXT_COLOR,
                          ),
                        ),
                      ),
                      8.heightBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: AppColors.BORDER_COLOR,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: suiteViewController.selectedGoods,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                          underline: Container(),
                          isDense: true,
                          items:
                              suiteViewController.typebiens.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                width: 74,
                                child: Text(
                                  items,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              suiteViewController.selectedGoods = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget caracteristic() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoTitle(
            "Caracteristiques",
          ),
          Wrap(
            spacing: 10,
            children: List.generate(
              suiteViewController.caracteristics.length,
              (index) {
                bool isSelected = false;
                List<String> test = suiteViewController.selectedCaracteristics
                    .where((c) => c == caracteristiqueKey[index])
                    .toList();
                if (test.isNotEmpty) {
                  setState(() {
                    isSelected = true;
                  });
                }
                return OnHoverEffect(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        List<String> test = suiteViewController
                            .selectedCaracteristics
                            .where((c) => c == caracteristiqueKey[index])
                            .toList();
                        if (test.isEmpty) {
                          suiteViewController.selectedCaracteristics
                              .add(caracteristiqueKey[index]);
                          isSelected = true;
                        } else {
                          suiteViewController.selectedCaracteristics
                              .removeWhere(
                                  (c) => c == caracteristiqueKey[index]);
                          isSelected = false;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 90,
                      width: 90,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.BLACK_COLOR
                            : AppColors.DISABLE_COLOR,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            caracteristiqueValue[index],
                            size: 14,
                            color: isSelected
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
                          ),
                          5.heightBox,
                          Text(
                            caracteristiqueKey[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: isSelected
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.BLACK_COLOR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          30.heightBox,
          Row(
            children: [
              BlocListener<AppBloc, AppState>(
                listener: ((context, state) {
                  if (state is SUCCESS) {
                    widget.showSuites.value = true;
                    setState(() {});
                  }
                }),
                child: OnHoverEffect(
                  child: InkWell(
                    onTap: saveSuite,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: 145,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.BLACK_COLOR,
                      ),
                      child: Text(
                        "Enregistrer",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.WHITE_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              10.widthBox,
              OnHoverEffect(
                child: InkWell(
                  onTap: () {
                    widget.showSuites.value = true;
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 145,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.DISABLE_COLOR,
                    ),
                    child: Text(
                      "Annuler",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.BLACK_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget modelInfo(
      {String? title,
      String? hint,
      TextEditingController? controller,
      bool? optinal}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ),
          8.heightBox,
          FormText(
            hint: hint,
            optinal: optinal,
            controller: controller,
            submitted: submitted,
          ),
        ],
      ),
    );
  }
}
