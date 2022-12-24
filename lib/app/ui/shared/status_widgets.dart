import 'package:bukara/app/ui/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AppInfo extends StatelessWidget {
  final Color? statusColor;
  final String? title;
  final String? subtitle;
  const AppInfo({super.key, this.statusColor, this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            // width: 300,
            decoration: BoxDecoration(
                color: AppColors.WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: AppColors.SHADOW_COLOR,
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.heightBox,
                Text(
                  subtitle!,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.SECOND_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: 8,
              height: double.infinity,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoandingInfo extends StatelessWidget {
  const LoandingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.WHITE_COLOR,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.SHADOW_COLOR,
            offset: Offset(1, 3),
            blurRadius: 3,
          ),
          BoxShadow(
            color: AppColors.SHADOW_COLOR,
            offset: Offset(-1, -3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Chargement...",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: AppColors.SECOND_TEXT_COLOR,
            ),
          ),
          10.widthBox,
          const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
