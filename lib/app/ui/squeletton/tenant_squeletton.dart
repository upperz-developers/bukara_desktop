import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantSqueletton extends StatelessWidget {
  const TenantSqueletton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          tabDetail(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  10,
                  (index) => tenantDetail(
                    index: index,
                    context: context,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tenantDetail({
    int? index,
    BuildContext? context,
  }) {
    double space = 10;
    return Container(
      padding: EdgeInsets.only(
        left: horizontalSpace,
        right: horizontalSpace,
        bottom: 20,
        top: 20,
      ),
      width: MediaQuery.of(context!).size.width,
      decoration: BoxDecoration(
        color: index! % 2 == 0 ? AppColors.WHITE_COLOR : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: tenantSquelton(),
          ),
          space.widthBox,
          Expanded(
            flex: 2,
            child: tenantSquelton(),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: tenantSquelton(),
          ),
          space.widthBox,
          Expanded(
            flex: 3,
            child: tenantSquelton(),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: Wrap(spacing: 30, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Shimmer(
                  colorOpacity: .15,
                  color: AppColors.BLACK_COLOR.withAlpha(4),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.DISABLE_COLOR,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Shimmer(
                  colorOpacity: .15,
                  color: AppColors.BLACK_COLOR.withAlpha(4),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.DISABLE_COLOR,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget tabDetail(BuildContext context) {
    double space = 10;
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalSpace,
        right: horizontalSpace,
        bottom: 30,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "#numero"),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Responsable"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Etat civile"),
            ),
            space.widthBox,
            Expanded(
              flex: 3,
              child: tabDetailModel(title: "Adresse physique"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Plus"),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabDetailModel({String? title}) {
    return Text(
      title!,
      style: GoogleFonts.montserrat(
        fontSize: 12,
      ),
    );
  }

  Widget tenantSquelton() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Shimmer(
          colorOpacity: .15,
          color: AppColors.BLACK_COLOR.withAlpha(30),
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.DISABLE_COLOR,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
