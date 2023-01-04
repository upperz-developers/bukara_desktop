import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/views/home/paiement/print_pdf.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailHistoric extends StatelessWidget {
  static String routeName = "/detail_paiement";
  const DetailHistoric({super.key});

  @override
  Widget build(BuildContext context) {
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
                                    "assets/icons/icon.png",
                                    fit: BoxFit.cover,
                                  )),
                              30.widthBox,
                              Expanded(
                                child: Text(
                                  "Recu de paiement",
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
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
                                    Text(
                                      "Upperz",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    15.heightBox,
                                    Text(
                                      "Une entreprise de developpement de solution informatique",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    15.heightBox,
                                    Text(
                                      "Id Nat: 19-G4701-N9812J",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "Num Impot: A2283021Q",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "CD/GOM/RCCM/21-A-01044",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    CustomDate(date: DateTime.now())
                                        .getFullDate,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                  21.heightBox,
                                  Text.rich(
                                    TextSpan(
                                      text: "Facture Num        ",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "UP3012220001",
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
                                  fontSize: 16,
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
                                      "David Baruka",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "Personne physique",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "+243 (0) 973959675 | baruka99.david@gmail.com",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "Maison louee | 3 chambres & 2 salons | 52, avenu,himbi, de goma, goma, rdc",
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          35.heightBox,
                          Row(
                            children: [
                              title1(title: "Libele", flex: 1),
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
                                            "Paiement du loyer du moi de fevrier"),
                                    content1(
                                        flex: 1,
                                        title:
                                            "This property is utilized so we can indicate a horizontal"),
                                    content1(
                                        flex: 1,
                                        title: "Numero de bordereau",
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
                              title1(title: "Libele", flex: 2),
                              3.widthBox,
                              title1(title: "Paye", flex: 1),
                              3.widthBox,
                              title1(title: "Rest", flex: 1),
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
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              3.widthBox,
                              content1(
                                  flex: 2,
                                  title: "Paiement du loyer du moi de fevrier"),
                              content1(flex: 1, title: "450\$"),
                              content1(
                                flex: 1,
                                title: "200\$",
                                isEnd: true,
                              ),
                            ],
                          ),
                          customDivider(context),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Upperz",
                                  style: GoogleFonts.montserrat(),
                                ),
                                5.heightBox,
                                Text(
                                  "52, avenu,himbi, de goma, goma, rdc",
                                  style: GoogleFonts.montserrat(),
                                ),
                              ],
                            ),
                          ),
                          customDivider(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Upperz",
                                style: GoogleFonts.montserrat(),
                              ),
                              Text(
                                "www.upper-z.com",
                                style: GoogleFonts.montserrat(),
                              ),
                              Text(
                                "baruka99.david@gmail.com",
                                style: GoogleFonts.montserrat(),
                              ),
                              Text(
                                "+243 (0) 973969675",
                                style: GoogleFonts.montserrat(),
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
              children: [
                OnHoverEffect(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                15.heightBox,
                OnHoverEffect(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: saveAndPrintPdf,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Iconsax.printer,
                        size: 24,
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
