import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/image_galerie.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/views/home/tenant/show_tenant.dart';
import 'package:bukara/app/ui/views/home/tenant/select_tenant_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:bukara/app/providers/shared/common_models.dart' as img;

class SuiteDetail extends StatefulWidget {
  static String routeName = "/detail_suite";
  const SuiteDetail({super.key});

  @override
  State<SuiteDetail> createState() => _SuiteDetailState();
}

class _SuiteDetailState extends State<SuiteDetail> {
  @override
  Widget build(BuildContext context) {
    Suite suiteDetail = ModalRoute.of(context)!.settings.arguments as Suite;
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: horizontalSpace,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail de l'appartement",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.heightBox,
                    if (suiteDetail.images!.isNotEmpty)
                      showImage(suiteDetail.images!),
                    45.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 150,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: suiteDetail.status! ? 400 : 900,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${suiteDetail.designation} - ${suiteDetail.price}\$ par mois",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          10.heightBox,
                                          Text(
                                            "#numero ${suiteDetail.number} (${suiteDetail.features!.bedroom} chambres - ${suiteDetail.features!.livingroom} salon)",
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          20.heightBox,
                                          Text(
                                            suiteDetail.description!,
                                            style: GoogleFonts.montserrat(
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                              fontSize: 12,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!suiteDetail.status!)
                                      Row(
                                        children: [
                                          30.widthBox,
                                          OnHoverEffect(
                                            child: InkWell(
                                              onTap: rentSuite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                100,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 15,
                                                  horizontal: 30,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.BLACK_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    100,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Louer cet appartement",
                                                  style: GoogleFonts.montserrat(
                                                    color:
                                                        AppColors.WHITE_COLOR,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(),
                                ),
                                (suiteDetail.status!)
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          caracteristic(suiteDetail),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, bottom: 20),
                                            child: Divider(),
                                          ),
                                          Text(
                                            "Autres informations",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          30.heightBox,
                                          otherInfo(
                                              suiteDetail.features!.other!),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: otherInfo(
                                                suiteDetail.features!.other!),
                                          ),
                                          50.widthBox,
                                          Expanded(
                                              child:
                                                  caracteristic(suiteDetail)),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          (suiteDetail.status!)
                              ? Container(
                                  margin: const EdgeInsets.only(top: 70),
                                  width: 400,
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    color: AppColors.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.SECOND_TEXT_COLOR,
                                          height: 1.5,
                                        ),
                                      ),
                                      15.heightBox,
                                      Text(
                                        "20 jours restants",
                                        style: GoogleFonts.montserrat(
                                          height: 1.5,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "20 dec - 30 janvier",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.SECOND_TEXT_COLOR,
                                          height: 1.5,
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Divider(),
                                      ),
                                      OnHoverEffect(
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const TenantInfo(),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.DISABLE_COLOR,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Iconsax.user,
                                                ),
                                              ),
                                              15.widthBox,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "John doe",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Personne physique",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: AppColors
                                                            .SECOND_TEXT_COLOR,
                                                        height: 1.5,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              15.widthBox,
                                              const Icon(
                                                Iconsax.arrow_right,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Divider(),
                                      ),
                                      OnHoverEffect(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Historique de paiement",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Paiement sur location de l'appartement",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: AppColors
                                                            .SECOND_TEXT_COLOR,
                                                        height: 1.5,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              15.widthBox,
                                              const Icon(
                                                Iconsax.arrow_right,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Divider(),
                                      ),
                                      TableCalendar(
                                        daysOfWeekStyle: DaysOfWeekStyle(
                                          weekdayStyle:
                                              GoogleFonts.montserrat(),
                                          weekendStyle: GoogleFonts.montserrat(
                                            color: Colors.black38,
                                          ),
                                        ),
                                        rowHeight: 53,
                                        headerStyle: HeaderStyle(
                                          formatButtonVisible: false,
                                          headerPadding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          titleCentered: true,
                                          leftChevronIcon: const Icon(
                                            Iconsax.arrow_left_2,
                                            color: AppColors.BLACK_COLOR,
                                          ),
                                          rightChevronIcon: const Icon(
                                            Iconsax.arrow_right_3,
                                            color: AppColors.BLACK_COLOR,
                                          ),
                                          titleTextStyle:
                                              GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        calendarStyle: CalendarStyle(
                                          weekendTextStyle:
                                              GoogleFonts.montserrat(
                                            color: Colors.black38,
                                          ),
                                          outsideTextStyle:
                                              GoogleFonts.montserrat(
                                            color: Colors.black38,
                                          ),
                                          todayTextStyle:
                                              GoogleFonts.montserrat(
                                            color: AppColors.WHITE_COLOR,
                                          ),
                                          weekNumberTextStyle:
                                              GoogleFonts.montserrat(),
                                          selectedTextStyle:
                                              GoogleFonts.montserrat(),
                                          selectedDecoration:
                                              const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  shape: BoxShape.circle),
                                          todayDecoration: const BoxDecoration(
                                            color: AppColors.BLACK_COLOR,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        availableGestures:
                                            AvailableGestures.all,
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2050, 3, 14),
                                        onDaySelected: (day1, day2) {},
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
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

  Widget caracteristic(Suite suite) {
    return Column(
      children: [
        caracteristicModel(
          title: "#numero ${suite.number}",
          icon: Iconsax.box,
        ),
        caracteristicModel(
          title:
              "${suite.address!.number}, ${suite.address!.street}, ${suite.address!.quarter}, commune, ${suite.address!.town}, province, ${suite.address!.country}",
          icon: Iconsax.map_1,
        ),
        caracteristicModel(
          title: "${suite.features!.bedroom} chambres",
          icon: Iconsax.box,
        ),
        caracteristicModel(
          title: "${suite.features!.livingroom} salons",
          icon: Iconsax.home,
        ),
        caracteristicModel(
          title: "${suite.features!.interntoilet} toillette interne",
          icon: Iconsax.safe_home,
        ),
        caracteristicModel(
          title: "${suite.features!.externtoilet} toillette externe",
          icon: Iconsax.activity,
        ),
      ],
    );
  }

  rentSuite() {
    Navigator.pushNamed(context, ShowTenantDialog.routeName);
  }

  Widget otherInfo(List<String> otherCarteristic) {
    return Column(
      children: [
        otherCaracteristicModel(
            title: "Connxion internet",
            icon: Iconsax.wifi,
            otherCarteristic: otherCarteristic),
        otherCaracteristicModel(
          title: "Cash power",
          icon: Iconsax.flash,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Snel",
          icon: Iconsax.flash,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Eau",
          icon: Iconsax.omega_circle,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Cuisine",
          icon: Iconsax.omega_circle,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Toilette interne",
          icon: Iconsax.safe_home,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Toillette externe",
          icon: Iconsax.activity,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Piscine",
          icon: Iconsax.activity,
          otherCarteristic: otherCarteristic,
        ),
        otherCaracteristicModel(
          title: "Parking",
          icon: Iconsax.activity,
          otherCarteristic: otherCarteristic,
        ),
      ],
    );
  }

  Widget caracteristicModel({IconData? icon, String? title, bool? exist}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child: Text(
              title!,
              style: GoogleFonts.montserrat(
                height: 1.5,
                decoration: exist == false ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherCaracteristicModel(
      {IconData? icon, String? title, List<String>? otherCarteristic}) {
    ValueNotifier<bool> isExist = ValueNotifier(false);
    if (otherCarteristic != null) {
      for (int i = 0; i < otherCarteristic.length; i++) {
        if (otherCarteristic[i] == title) {
          isExist.value = true;
          break;
        }
      }
    }
    return ValueListenableBuilder(
        valueListenable: isExist,
        builder: (context, bool exist, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Icon(icon),
                15.widthBox,
                Expanded(
                  child: Text(
                    title!,
                    style: GoogleFonts.montserrat(
                      height: 1.5,
                      decoration:
                          exist == false ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget showImage(List<img.Image> images) {
    return Row(
      children: [
        Expanded(
          child: OnHoverEffect(
            child: InkWell(
              onTap: () {
                showImageGalerie(images: images, index: 0);
              },
              child: Container(
                height: 560,
                width: 560,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.SECOND_CARD_COLOR,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(images[0].url!),
                    fit: BoxFit.cover,
                  ),
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
                  child: InkWell(
                    onTap: () {
                      showImageGalerie(images: images, index: 1);
                    },
                    child: Container(
                      height: 276,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(images[1].url!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {
                      showImageGalerie(images: images, index: 2);
                    },
                    child: Container(
                      height: 276,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(images[2].url!),
                          fit: BoxFit.cover,
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
                  child: InkWell(
                    onTap: () {
                      showImageGalerie(images: images, index: 3);
                    },
                    child: Container(
                      height: 276,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(images[3].url!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {
                      showImageGalerie(images: images, index: 4);
                    },
                    child: Container(
                      height: 276,
                      width: 250,
                      decoration: BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(images[4].url!),
                          fit: BoxFit.cover,
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

  void showImageGalerie({List<img.Image>? images, int? index}) {
    showDialog(
      context: context,
      builder: (context) => SuiteGaleryImage(
        images: images,
        index: index,
      ),
    );
  }
}
