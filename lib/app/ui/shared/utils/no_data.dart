import 'package:bukara/app/providers/shared/common_models.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class NoData extends StatelessWidget {
  final Function() onTap;
  final List<ErrorData> dueTo;
  const NoData({super.key, required this.onTap, required this.dueTo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/no_data.svg",
            ),
            15.heightBox,
            ...List.generate(
              dueTo.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (dueTo[index].field != null)
                    Text(
                      dueTo[index].field!,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (dueTo[index].rule != null)
                    Text(
                      dueTo[index].rule!,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                      ),
                    ),
                  5.heightBox,
                  if (dueTo[index].message != null)
                    Text(
                      dueTo[index].message!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        height: 1.5,
                      ),
                    ),
                  if (index < dueTo.length - 1) 10.heightBox,
                ],
              ),
            ),
            15.heightBox,
            OnHoverEffect(
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColors.DISABLE_COLOR,
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: Text(
                        "Reessayer",
                        style: GoogleFonts.montserrat(),
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
}
