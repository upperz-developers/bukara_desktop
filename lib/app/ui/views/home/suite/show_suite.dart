import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/providers/suite/provider.dart';
import 'package:bukara/app/ui/views/home/suite/detail_suite.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowSuite extends StatefulWidget {
  const ShowSuite({super.key});

  @override
  State<ShowSuite> createState() => _ShowSuiteState();
}

class _ShowSuiteState extends State<ShowSuite> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          30.heightBox,
          tabDetail(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  suites.length,
                  (index) => suiteDetail(
                    index: index,
                    suite: suites[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pagination() {
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalSpace,
        right: horizontalSpace,
        top: 30,
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "1 sur 13",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: AppColors.SECOND_TEXT_COLOR,
            ),
          ),
          15.widthBox,
          OnHoverEffect(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.DISABLE_COLOR,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Iconsax.arrow_left_1,
                  color: AppColors.BLACK_COLOR,
                ),
              ),
            ),
          ),
          5.widthBox,
          OnHoverEffect(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.DISABLE_COLOR,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Iconsax.arrow_right_4,
                  color: AppColors.BLACK_COLOR,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabDetail() {
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
            SizedBox(
              width: 50,
              child: tabDetailModel(title: "#Num."),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Designation"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Prix par mois"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Responsable"),
            ),
            space.widthBox,
            Expanded(
              flex: 3,
              child: tabDetailModel(title: "Adresse complet"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Etat"),
            ),
            space.widthBox,
            SizedBox(
              width: 70,
              child: tabDetailModel(title: "Plus"),
            ),
          ],
        ),
      ),
    );
  }

  Widget suiteDetail({
    int? index,
    Suite? suite,
  }) {
    double space = 10;
    return Container(
      padding: EdgeInsets.only(
        left: horizontalSpace,
        right: horizontalSpace,
        bottom: 20,
        top: 20,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: index! % 2 == 0 ? AppColors.WHITE_COLOR : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: suiteDetailModel(
              title: "00${index + 1}",
            ),
          ),
          space.widthBox,
          Expanded(
            flex: 2,
            child: suite!.designation == null
                ? const SizedBox.shrink()
                : suiteDetailModel(title: "${suite.designation}"),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: suiteDetailModel(title: "${suite.price} USD"),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: suite.status!
                ? suiteDetailModel(title: "John jean")
                : const SizedBox.shrink(),
          ),
          space.widthBox,
          Expanded(
            flex: 3,
            child: suiteDetailModel(
                title:
                    "${suite.address!.number}, ${suite.address!.street}, ${suite.address!.quarter}, commune, ${suite.address!.town}, province, ${suite.address!.country}"),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.DISABLE_COLOR,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                suite.status! ? "Occupe" : "Inoccupe",
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                ),
              ),
            ),
          ),
          space.widthBox,
          SizedBox(
            width: 70,
            child: Wrap(
              spacing: 15,
              children: [
                modelAction(
                  icon: Iconsax.edit,
                ),
                modelAction(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SuiteDetail.routeName,
                      arguments: suite,
                    );
                  },
                  icon: Iconsax.more,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget modelAction({
    Function()? onTap,
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon),
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

  Widget suiteDetailModel({String? title}) {
    return Text(
      title!,
      style: GoogleFonts.montserrat(
        fontSize: 13,
        color: AppColors.SECOND_TEXT_COLOR,
        height: 1.6,
      ),
    );
  }
}
