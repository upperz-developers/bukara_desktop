import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/views/home/paiement/show_historic.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoricOfPaiement extends StatelessWidget {
  const HistoricOfPaiement({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: horizontalSpace,
                right: horizontalSpace,
                bottom: 20,
                top: 15,
              ),
              child: appBar(context, title: "Historique de paiements"),
            ),
            Expanded(
              child: Column(children: [
                infoTabBar(),
                const ShowPaiementHistoric(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalSpace),
      decoration: const BoxDecoration(
        color: AppColors.DISABLE_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.BORDER_COLOR,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: "Tapez un mot cle",
                          helperStyle: GoogleFonts.montserrat(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    10.widthBox,
                    const Icon(
                      Iconsax.search_normal,
                      color: AppColors.SECOND_TEXT_COLOR,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
