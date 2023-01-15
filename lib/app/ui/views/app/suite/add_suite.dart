import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/ui/view_controller/suite_view_controller.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

bool? isSuiteEdit;
Suite? suiteToEdit;

class AddSuite extends StatefulWidget {
  final ValueNotifier<bool> showSuites;
  const AddSuite({super.key, required this.showSuites});

  @override
  State<AddSuite> createState() => _AddSuiteState();
}

class _AddSuiteState extends State<AddSuite> {
  SuiteViewController suiteViewController = SuiteViewController();

  removeImage(index) {
    setState(() {
      if (isSuiteEdit == true) {
        suiteViewController.editedImage.removeWhere(
            (img) => img['imageId'] == suiteToEdit!.images![index]);
        switch (index) {
          case 0:
            suiteViewController.changedImageAtIndex0 = null;
            break;
          case 1:
            suiteViewController.changedImageAtIndex1 = null;
            break;
          case 2:
            suiteViewController.changedImageAtIndex2 = null;
            break;
          case 3:
            suiteViewController.changedImageAtIndex3 = null;
            break;
          default:
            suiteViewController.changedImageAtIndex4 = null;
        }
        return;
      }
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
    if (isSuiteEdit == true) {
      suiteViewController.selectedSuiteNumber = suiteToEdit!.number.toString();
      suiteViewController.selectedCountBedRoom =
          suiteToEdit!.features!.bedroom.toString();
      suiteViewController.selectedCountExternToilet =
          suiteToEdit!.features!.externtoilet.toString();
      suiteViewController.selectedCountInternToilet =
          suiteToEdit!.features!.interntoilet.toString();
      suiteViewController.selectedCountLeavingRoom =
          suiteToEdit!.features!.livingroom.toString();
      suiteViewController.selectedGoods = suiteToEdit!.typeBien!.designation!;
      suiteViewController.selectedSuite =
          suiteToEdit!.typeAppartement!.designation!;
      suiteViewController.selectedCaracteristics
          .addAll(suiteToEdit!.features!.other!);
    }
    super.initState();
  }

  bool submitted = false;
  void saveSuite() {
    if (suiteViewController.validated(context)) {
      suiteViewController.submit(context);
      return;
    }
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalSpace - 30,
          right: horizontalSpace - 30,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightBox,
                    SizedBox(
                      width: 500,
                      child: Text(
                        isSuiteEdit == true
                            ? "Modification de ${suiteToEdit!.designation}"
                            : "Ajouter un appartement",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
          hint: isSuiteEdit == true && suiteToEdit!.address!.country != null
              ? suiteToEdit!.address!.country
              : "Rep dem du congo",
          controller: suiteViewController.addressController.country,
        ),
        modelInfo(
          title: "Province",
          hint: isSuiteEdit == true && suiteToEdit!.address!.city != null
              ? suiteToEdit!.address!.city
              : "Nord-kivu",
          controller: suiteViewController.addressController.city,
        ),
        modelInfo(
          title: "Ville",
          hint: isSuiteEdit == true && suiteToEdit!.address!.town != null
              ? suiteToEdit!.address!.town
              : "Goma",
          controller: suiteViewController.addressController.town,
        ),
        modelInfo(
          title: "Commune",
          hint: isSuiteEdit == true && suiteToEdit!.address!.common != null
              ? suiteToEdit!.address!.common
              : "Goma",
          controller: suiteViewController.addressController.commune,
        ),
        modelInfo(
          title: "Quartier",
          hint: isSuiteEdit == true && suiteToEdit!.address!.quarter != null
              ? suiteToEdit!.address!.quarter
              : "Entrer le cartier",
          controller: suiteViewController.addressController.quater,
        ),
        modelInfo(
          title: "Avenue",
          hint: isSuiteEdit == true && suiteToEdit!.address!.street != null
              ? suiteToEdit!.address!.street
              : "Entrer l'avenu",
          controller: suiteViewController.addressController.avenue,
        ),
        modelInfo(
          title: "Numéro",
          hint: isSuiteEdit == true && suiteToEdit!.address!.number != null
              ? suiteToEdit!.address!.number.toString()
              : "Entrer le numéro",
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
            child: suiteViewController.images.isNotEmpty ||
                    suiteViewController.changedImageAtIndex0 != null
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
                            isSuiteEdit == true &&
                                    suiteToEdit!.images!.isNotEmpty
                                ? suiteViewController.changedImageAtIndex0!
                                : suiteViewController.images[0],
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
                      if (isSuiteEdit == true) {
                        if (suiteToEdit!.images!.isNotEmpty) {
                          suiteViewController
                              .pickOneImage(
                            imageId: suiteToEdit!.images![0].id!,
                            index: 0,
                          )
                              .then((value) {
                            setState(() {});
                          });
                        } else {
                          suiteViewController.pickImages().then((value) {
                            setState(() {});
                          });
                        }
                      } else {
                        suiteViewController.pickImages().then((value) {
                          setState(() {});
                        });
                      }
                    },
                    child:
                        isSuiteEdit == true && suiteToEdit!.images!.isNotEmpty
                            ? Container(
                                height: 448,
                                width: 620,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.SECOND_CARD_COLOR,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        suiteToEdit!.images![0].url!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
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
                                      "Cliquer sur une des cases\npour ajouter une ou  plusieurs images",
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
                  child: suiteViewController.images.length > 1 ||
                          suiteViewController.changedImageAtIndex1 != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  isSuiteEdit == true &&
                                          suiteToEdit!.images!.isNotEmpty
                                      ? suiteViewController
                                          .changedImageAtIndex1!
                                      : suiteViewController.images[1],
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
                            if (isSuiteEdit == true) {
                              if (suiteToEdit!.images!.isNotEmpty) {
                                suiteViewController
                                    .pickOneImage(
                                  imageId: suiteToEdit!.images![1].id!,
                                  index: 1,
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              } else {
                                suiteViewController.pickImages().then((value) {
                                  setState(() {});
                                });
                              }
                            } else {
                              suiteViewController.pickImages().then((value) {
                                setState(() {});
                              });
                            }
                          },
                          child: isSuiteEdit == true &&
                                  suiteToEdit!.images!.isNotEmpty
                              ? Container(
                                  height: 220,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.SECOND_CARD_COLOR,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          suiteToEdit!.images![1].url!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
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
                  child: suiteViewController.images.length > 2 ||
                          suiteViewController.changedImageAtIndex2 != null
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
                                  isSuiteEdit == true &&
                                          suiteToEdit!.images!.isNotEmpty
                                      ? suiteViewController
                                          .changedImageAtIndex2!
                                      : suiteViewController.images[2],
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
                            if (isSuiteEdit == true) {
                              if (suiteToEdit!.images!.isNotEmpty) {
                                suiteViewController
                                    .pickOneImage(
                                  imageId: suiteToEdit!.images![2].id!,
                                  index: 2,
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              } else {
                                suiteViewController.pickImages().then((value) {
                                  setState(() {});
                                });
                              }
                            } else {
                              suiteViewController.pickImages().then((value) {
                                setState(() {});
                              });
                            }
                          },
                          child: isSuiteEdit == true &&
                                  suiteToEdit!.images!.isNotEmpty
                              ? Container(
                                  height: 220,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.SECOND_CARD_COLOR,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          suiteToEdit!.images![2].url!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
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
                  child: suiteViewController.images.length > 3 ||
                          suiteViewController.changedImageAtIndex3 != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              child: SizedBox(
                                height: 220,
                                width: 250,
                                child: Image.file(
                                  isSuiteEdit == true &&
                                          suiteToEdit!.images!.isNotEmpty
                                      ? suiteViewController
                                          .changedImageAtIndex3!
                                      : suiteViewController.images[3],
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
                            if (isSuiteEdit == true) {
                              if (suiteToEdit!.images!.isNotEmpty) {
                                suiteViewController
                                    .pickOneImage(
                                  imageId: suiteToEdit!.images![3].id!,
                                  index: 3,
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              } else {
                                suiteViewController.pickImages().then((value) {
                                  setState(() {});
                                });
                              }
                            } else {
                              suiteViewController.pickImages().then((value) {
                                setState(() {});
                              });
                            }
                          },
                          child: isSuiteEdit == true &&
                                  suiteToEdit!.images!.isNotEmpty
                              ? Container(
                                  height: 220,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.SECOND_CARD_COLOR,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          suiteToEdit!.images![3].url!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
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
                  child: suiteViewController.images.length > 4 ||
                          suiteViewController.changedImageAtIndex4 != null
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
                                  isSuiteEdit == true &&
                                          suiteToEdit!.images!.isNotEmpty
                                      ? suiteViewController
                                          .changedImageAtIndex4!
                                      : suiteViewController.images[4],
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
                            if (isSuiteEdit == true) {
                              if (suiteToEdit!.images!.isNotEmpty) {
                                suiteViewController
                                    .pickOneImage(
                                  imageId: suiteToEdit!.images![4].id!,
                                  index: 4,
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              } else {
                                suiteViewController.pickImages().then((value) {
                                  setState(() {});
                                });
                              }
                            } else {
                              suiteViewController.pickImages().then((value) {
                                setState(() {});
                              });
                            }
                          },
                          child: isSuiteEdit == true &&
                                  suiteToEdit!.images!.isNotEmpty
                              ? Container(
                                  height: 220,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.SECOND_CARD_COLOR,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          suiteToEdit!.images![3].url!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
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
          hint: isSuiteEdit == true && suiteToEdit!.designation != null
              ? suiteToEdit!.designation
              : "Designation de l'entreprise",
          controller: suiteViewController.designation,
        ),
        modelInfo(
          title: "Prix",
          hint: isSuiteEdit == true && suiteToEdit!.price != null
              ? "${suiteToEdit!.price} USD"
              : "montant en USD",
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
              hintText: isSuiteEdit == true && suiteToEdit!.description != null
                  ? suiteToEdit!.description
                  : "Description de l'entreprise",
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
                        "#numéro",
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
                          vertical: 5,
                          horizontal: 10,
                        ),
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
            "Caractéristiques",
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
                listener: ((context, state) {}),
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
                    alertMessage(context,
                        action: "Annuler",
                        action1: "Continuer",
                        body:
                            "Etes-vous sûr de vouloir annuler? Si vous annulez l'opération les informations saisies seront effacées",
                        onTap1: () {
                          Navigator.pop(context);
                        },
                        head: "Annuler l'opération",
                        onTap: () {
                          Navigator.pop(context);
                          isSuiteEdit = false;
                          suiteToEdit = null;
                          widget.showSuites.value = true;
                        });
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
