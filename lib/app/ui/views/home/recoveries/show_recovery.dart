import 'package:bukara/app/providers/recovery/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/utility_functions.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/views/home/recoveries/detail_recovery.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowRecovery extends StatefulWidget {
  final List<ContratData> contratData;
  const ShowRecovery({super.key, required this.contratData});

  @override
  State<ShowRecovery> createState() => _ShowRecoveryState();
}

class _ShowRecoveryState extends State<ShowRecovery> {
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
                  widget.contratData.length,
                  (index) => recoveryDetail(
                      index: index, contratData: widget.contratData[index]),
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
              width: 40,
              child: tabDetailModel(title: "#num"),
            ),
            30.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Libele"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Montant"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Date debut"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Date fin"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Jours restants"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Locataire"),
            ),
            space.widthBox,
            SizedBox(
              width: 30,
              child: tabDetailModel(title: "Plus"),
            ),
          ],
        ),
      ),
    );
  }

  Widget recoveryDetail({
    int? index,
    required ContratData contratData,
  }) {
    double space = 10;
    DateTime startAt = DateTime.parse(contratData.createdAt!);
    DateTime recoverAt = DateTime.parse(contratData.dateRecovery!);
    return Stack(
      children: [
        Container(
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
                width: 40,
                child: Text(
                  "0${index + 1}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: AppColors.SECOND_TEXT_COLOR,
                    height: 1.6,
                  ),
                ),
              ),
              30.widthBox,
              Expanded(
                flex: 2,
                child: suiteDetailModel(title: "${contratData.labelStr}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                    title: "${contratData.rentalContrat!.amount} USD"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                    title: "${startAt.day}/${startAt.month}/${startAt.year}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                    title:
                        "${recoverAt.day}/${recoverAt.month}/${recoverAt.year}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: Text(
                  dayLeft(
                      start: contratData.rentalContrat!.startDate!,
                      end: contratData.dateRecovery!),
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                  title:
                      "${contratData.rentalContrat!.landlord!.name} ${contratData.rentalContrat!.landlord!.lastname}",
                ),
              ),
              space.widthBox,
              SizedBox(
                height: 30,
                width: 30,
                child: modelAction(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => DetailRecovery(
                        contratData: contratData,
                      ),
                    );
                  },
                  icon: Iconsax.more,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: horizontalSpace - 35,
          bottom: 5,
          child: Container(
            width: 10,
            decoration: const BoxDecoration(
              color: AppColors.GREEN_COLOR,
            ),
          ),
        ),
      ],
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
