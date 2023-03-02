import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/pop_pup.dart';
import 'package:bukara/app/ui/shared/utils/utility_functions.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/views/app/home.dart';
import 'package:bukara/app/ui/views/app/suite/rent_suite.dart';
import 'package:bukara/app/ui/views/app/tenant/select_tenant_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:bukara/app/providers/shared/common_models.dart' as img;

class SuiteDetail extends StatefulWidget {
  static String routeName = "/detail_suite";
  const SuiteDetail({super.key});

  @override
  State<SuiteDetail> createState() => _SuiteDetailState();
}

class _SuiteDetailState extends State<SuiteDetail> {
  AppBloc? bloc;
  @override
  void initState() {
    bloc = AppBloc();
    super.initState();
  }

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
                      "Détail de l'appartement",
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
                                            "#numéro ${suiteDetail.number} (${suiteDetail.features!.bedroom} chambres - ${suiteDetail.features!.livingroom} salon)",
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
                                              onTap: () {
                                                rentSuite(suiteDetail.id!);
                                              },
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
                                        "${suiteDetail.contrats![0].landlord!.name} ${suiteDetail.contrats![0].landlord!.lastname}",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      10.heightBox,
                                      Text(
                                        "${suiteDetail.contrats![0].landlord!.email}",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      20.heightBox,
                                      Text(
                                        "${suiteDetail.contrats![0].amount}\$ le mois",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      200.heightBox,
                                      line(),
                                      Text(
                                        "Contrat enrégistre par",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      15.heightBox,
                                      if (suiteDetail.contrats![0].user!.name !=
                                          null)
                                        Column(
                                          children: [
                                            Text(
                                                "${suiteDetail.contrats![0].user!.name} ${suiteDetail.contrats![0].user!.lastname}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            5.heightBox,
                                          ],
                                        ),
                                      Text(
                                        "${suiteDetail.contrats![0].landlord!.email}",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      30.heightBox,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Signé ${CustomDate(date: DateTime.parse(suiteDetail.contrats![0].createdAt ?? DateTime.now().toString())).getFullDate}",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                            ),
                                          ),
                                          10.heightBox,
                                          Text(
                                            "Mise en effet ${CustomDate(date: DateTime.parse(suiteDetail.contrats![0].startDate!)).getFullDate}",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                            ),
                                          ),
                                          if (suiteDetail
                                                  .contrats![0].endDate !=
                                              null)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                5.heightBox,
                                                Text(
                                                  "Resilie ${CustomDate(date: DateTime.parse(suiteDetail.contrats![0].endDate!)).getFullDate}",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .SECOND_TEXT_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          30.heightBox,
                                          OnHoverEffect(
                                            child: InkWell(
                                              onTap: () {
                                                bloc!.add(
                                                  BREACKCONTRAT(
                                                    contratId: suiteDetail
                                                        .contrats![0].id,
                                                    tenantId: suiteDetail
                                                        .contrats![0]
                                                        .landlord!
                                                        .id,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: AppColors.BLACK_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                alignment: Alignment.center,
                                                child: BlocListener<AppBloc,
                                                    AppState>(
                                                  bloc: bloc,
                                                  listener: (context, state) {
                                                    if (state is SUCCESS) {
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              Home.routeName,
                                                              (route) => false);
                                                    } else if (state is ERROR) {
                                                      errorModel(
                                                        context,
                                                        dueTo: state
                                                            .dueTo!.errors!,
                                                      );
                                                    }
                                                  },
                                                  child: BlocBuilder<AppBloc,
                                                      AppState>(
                                                    bloc: bloc,
                                                    builder: (context, state) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          state is LOADING
                                                              ? const SizedBox(
                                                                  height: 15,
                                                                  width: 15,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .WHITE_COLOR,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "Résilier le contrat",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .WHITE_COLOR,
                                                                  ),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      24.heightBox,
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

  Widget module2(IconData? icon, String? title, String? message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "$title",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "$message",
                style: GoogleFonts.montserrat(
                  color: AppColors.SECOND_TEXT_COLOR,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget module(
    IconData? icon,
    String? message,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child: Text(
              "$message",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget caracteristic(Suite suite) {
    return Column(
      children: [
        caracteristicModel(
          title: "#numéro ${suite.number}",
          icon: Iconsax.box,
        ),
        caracteristicModel(
          title:
              "${suite.address!.number}, ${suite.address!.street}, ${suite.address!.quarter}, ${suite.address!.common}, ${suite.address!.town}, province, ${suite.address!.country}",
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

  rentSuite(String id) {
    Navigator.pushNamed(context, ShowTenantDialog.routeName).then((value) {
      if (value != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => RentSuite(
            tenantModel: value as TenantModel,
            suiteId: id,
          ),
        ).then((value) {
          if (value == "success") {
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          }
        });
      }
    });
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
                showImageGalerie(context, images: images, index: 0);
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
                      showImageGalerie(context, images: images, index: 1);
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
                      showImageGalerie(context, images: images, index: 2);
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
                      showImageGalerie(context, images: images, index: 3);
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
                      showImageGalerie(context, images: images, index: 4);
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
}
