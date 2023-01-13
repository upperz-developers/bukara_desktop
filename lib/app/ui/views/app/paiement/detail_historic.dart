import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/views/app/paiement/print_pdf.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailHistoric extends StatelessWidget {
  static String routeName = "/detail_paiement";
  const DetailHistoric({super.key});

  @override
  Widget build(BuildContext context) {
    PayementHistoric payement =
        ModalRoute.of(context)!.settings.arguments as PayementHistoric;
    Enterprise enterprise = getEnterprisePrefs();
    DateTime paiedAt = DateTime.parse(payement.createdAt!);
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
      body: Stack(
        children: [
          Column(
            children: [
              100.heightBox,
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        bottom: 30, left: 30, right: 30, top: 0),
                    child: Container(
                      padding: const EdgeInsets.all(60),
                      height: 1122.519685,
                      width: 793.7007874,
                      decoration: const BoxDecoration(
                        color: AppColors.WHITE_COLOR,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.asset(
                                    "assets/icons/bukara.jpg",
                                    fit: BoxFit.cover,
                                  )),
                              30.widthBox,
                              Expanded(
                                child: Text(
                                  "Reçu de paiement",
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          customDivider(context),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (enterprise.designation != null)
                                      Text(
                                        "${enterprise.designation}",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (enterprise.description != null)
                                      Column(
                                        children: [
                                          15.heightBox,
                                          Text(
                                            "${enterprise.description}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (enterprise.idnat != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          15.heightBox,
                                          Text(
                                            "${enterprise.idnat}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (enterprise.impot != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          10.heightBox,
                                          Text(
                                            "${enterprise.impot}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (enterprise.rccm != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          10.heightBox,
                                          Text(
                                            "${enterprise.rccm}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    CustomDate(date: paiedAt).getFullDate,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  21.heightBox,
                                  Text.rich(
                                    TextSpan(
                                      text: "Facture: ",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${enterprise.designation?.substring(0, 3)}${paiedAt.day}${paiedAt.month}${paiedAt.year}${paiedAt.second}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          customDivider(context),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Locataire:",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              50.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    4.heightBox,
                                    Text(
                                      "${payement.contratData!.rentalContrat!.landlord!.name} ${payement.contratData!.rentalContrat!.landlord!.lastname}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "${payement.contratData!.rentalContrat!.landlord!.email}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "${payement.contratData!.rentalContrat!.appartement!.designation} | numero ${payement.contratData!.rentalContrat!.appartement!.number},${payement.contratData!.rentalContrat!.appartement!.features!.bedroom} chambres - ${payement.contratData!.rentalContrat!.appartement!.features!.livingroom} salon| ${payement.contratData!.rentalContrat!.appartement!.address}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          35.heightBox,
                          Row(
                            children: [
                              title1(title: "Libellé", flex: 1),
                              3.widthBox,
                              title1(title: "Methode de paiement", flex: 1),
                              3.widthBox,
                              title1(title: "Numero de bordereau", flex: 1),
                            ],
                          ),
                          3.heightBox,
                          Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(30, 83, 133, 153),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    content1(
                                        flex: 1,
                                        title:
                                            "${payement.contratData!.labelStr}"),
                                    content1(
                                        flex: 1, title: "${payement.type}"),
                                    content1(
                                        flex: 1,
                                        title: payement.type == "cash"
                                            ? ""
                                            : "${payement.transactionId}",
                                        isEnd: true),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 222.5,
                                child: Container(
                                  width: 3,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 448,
                                child: Container(
                                  width: 3,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          35.heightBox,
                          Row(
                            children: [
                              Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 43, 81, 133),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "#num",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                              3.widthBox,
                              title1(title: "Libellé", flex: 2),
                              3.widthBox,
                              title1(title: "Paye", flex: 1),
                            ],
                          ),
                          3.heightBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "1",
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                              3.widthBox,
                              content1(
                                  flex: 2,
                                  title: "${payement.contratData!.labelStr}"),
                              content1(flex: 1, title: "${payement.amount}\$"),
                            ],
                          ),
                          customDivider(context),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Merci de nous avoir fait confiance",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${enterprise.banks?[0].accountName} | ${enterprise.banks?[0].bank} | ${enterprise.banks?[0].accountNumber}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          customDivider(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${enterprise.designation}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${enterprise.site}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${enterprise.email}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${enterprise.phones}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 150,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnHoverEffect(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            size: 18,
                          ),
                          10.widthBox,
                          Text(
                            "Retour",
                            style: GoogleFonts.montserrat(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                15.heightBox,
                OnHoverEffect(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      saveAndPrintPdf(
                          enterprise: enterprise, payement: payement);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.printer,
                            size: 18,
                          ),
                          10.widthBox,
                          Text(
                            "Imprimer",
                            style: GoogleFonts.montserrat(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget title1({String? title, int? flex}) {
    return Expanded(
      flex: flex!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 43, 81, 133),
        ),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppColors.WHITE_COLOR,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget content1({String? title, bool? isEnd, required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: GoogleFonts.montserrat(
            color: AppColors.BLACK_COLOR,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget customDivider(BuildContext context) {
    return Container(
      height: 1.5,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 15, bottom: 40),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 86, 86, 86),
      ),
    );
  }
}
