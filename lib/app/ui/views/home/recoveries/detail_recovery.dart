import 'package:bukara/app/providers/recovery/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/utility_functions.dart';
import 'package:bukara/app/ui/views/home/paiement/paye_rent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailRecovery extends StatelessWidget {
  final ContratData contratData;
  const DetailRecovery({super.key, required this.contratData});

  @override
  Widget build(BuildContext context) {
    DateTime startAt = DateTime.parse(contratData.createdAt!);
    DateTime recoverAt = DateTime.parse(contratData.dateRecovery!);
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Detail recouvrement",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
        20.heightBox,
        SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${dayLeft(start: DateTime.now().toString(), end: contratData.dateRecovery!)} restants",
                  style: GoogleFonts.montserrat(
                    height: 1.5,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${CustomDate(date: startAt).getFullDate} - ${CustomDate(date: recoverAt).getFullDate}",
                  style: GoogleFonts.montserrat(
                    color: AppColors.SECOND_TEXT_COLOR,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${contratData.rentalContrat!.landlord!.name} ${contratData.rentalContrat!.landlord!.lastname}",
                            style: GoogleFonts.montserrat(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${contratData.rentalContrat!.landlord!.email}",
                            style: GoogleFonts.montserrat(
                              color: AppColors.SECOND_TEXT_COLOR,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.widthBox,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.DISABLE_COLOR,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Locataire",
                        style: GoogleFonts.montserrat(
                          color: AppColors.SECOND_TEXT_COLOR,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    15.widthBox,
                  ],
                ),
                20.heightBox,
                Text(
                  "${contratData.rentalContrat!.appartement!.designation} - (${contratData.rentalContrat!.appartement!.features!.bedroom} chambres & ${contratData.rentalContrat!.appartement!.features!.livingroom} salon)",
                  style: GoogleFonts.montserrat(),
                ),
                Text(
                  "${contratData.rentalContrat!.appartement!.typeAppartement!.designation} - ${contratData.rentalContrat!.appartement!.typeBien!.designation}",
                  style: GoogleFonts.montserrat(
                    color: AppColors.SECOND_TEXT_COLOR,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Text.rich(
                  TextSpan(
                    text: "${contratData.rentalContrat!.amount}",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: " USD par mois",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${contratData.rentalContrat!.user!.email}",
                            style: GoogleFonts.montserrat(
                              height: 1.5,
                            ),
                          ),
                          Text(
                            contratData.rentalContrat!.user!.name == null
                                ? "Pas definit"
                                : "${contratData.rentalContrat!.user!.email}",
                            style: GoogleFonts.montserrat(
                              color: AppColors.SECOND_TEXT_COLOR,
                              height: 1.5,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    15.widthBox,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.DISABLE_COLOR,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Signateur",
                        style: GoogleFonts.montserrat(
                          color: AppColors.SECOND_TEXT_COLOR,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    15.widthBox,
                  ],
                ),
                50.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OnHoverEffect(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => PayeRent(
                                contratData: contratData,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.BLACK_COLOR,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Payer le loyer",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: AppColors.WHITE_COLOR,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: OnHoverEffect(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.DISABLE_COLOR,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Annuler",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
