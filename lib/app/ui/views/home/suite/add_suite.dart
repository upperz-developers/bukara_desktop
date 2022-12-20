import 'package:bukara/app/ui/view_controller/suite_view_controller.dart';
import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:bukara/app/ui/views/start/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/views/start/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> appartType = [
  "apartement",
  "maison",
  "studio",
];

List<String> goodType = [
  "simple",
  "Meuble",
];

List<String> count = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
];

class AddSuite extends StatefulWidget {
  const AddSuite({super.key});

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
          title: "Reference",
          hint: "Entrez la reference",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Pays",
          hint: "Rep dem du congo",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Province",
          hint: "Nord-kivu",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Ville",
          hint: "Goma",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Commune",
          hint: "Goma",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Quartier",
          hint: "Entrer le cartier",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Avenue",
          hint: "Entrer l'avenu",
          controller: TextEditingController(),
        ),
        modelInfo(
          title: "Numero",
          hint: "Entrer le numero",
          controller: TextEditingController(),
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
          "Entreprise",
        ),
        modelInfo(
          title: "Designation",
          hint: "Designation de l'entreprise",
          controller: TextEditingController(),
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
              color: AppColors.BORDER_COLOR,
            ),
          ),
          child: TextField(
            style: GoogleFonts.montserrat(
              fontSize: 12,
            ),
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
                          // Initial Value
                          value: suiteViewController.selectedCountBedRoom,
                          borderRadius: BorderRadius.circular(4),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          // Array list of items
                          isDense: true,
                          items: count.map((String items) {
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
                          // After selecting the desired option,it will
                          // change button value to selected value
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
                          // Initial Value
                          value: suiteViewController.selectedCountInternToilet,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: Container(), isDense: true,
                          // Array list of items
                          items: count.map((String items) {
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
                          // After selecting the desired option,it will
                          // change button value to selected value
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
                          // Initial Value
                          underline: Container(),
                          value: suiteViewController.selectedCountExternToilet,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: count.map((String items) {
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
                          // After selecting the desired option,it will
                          // change button value to selected value
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
              10.widthBox,
              Expanded(
                child: modelInfo(
                  title: "Prix",
                  hint: "1 USD",
                  controller: TextEditingController(),
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
                          // Initial Value
                          value: suiteViewController.selectedSuite,
                          borderRadius: BorderRadius.circular(4),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          // Array list of items
                          isDense: true,
                          items: appartType.map((String items) {
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
                          // After selecting the desired option,it will
                          // change button value to selected value
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
                          // Initial Value
                          value: suiteViewController.selectedGoods,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          underline: Container(), isDense: true,
                          // Array list of items
                          items: goodType.map((String items) {
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
                          // After selecting the desired option,it will
                          // change button value to selected value
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
            // submitted: submitted,
          ),
        ],
      ),
    );
  }
}
