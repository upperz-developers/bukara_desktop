import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/constants.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/squeletton/paiement_squeletton.dart';
import 'package:bukara/app/ui/views/app/paiement/detail_historic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class PeymentPerRecovery extends StatefulWidget {
  static String routeName = "/payement_per_rcovery";
  const PeymentPerRecovery({super.key});

  @override
  State<PeymentPerRecovery> createState() => _PeymentPerRecoveryState();
}

class _PeymentPerRecoveryState extends State<PeymentPerRecovery> {
  AppBloc? bloc;
  @override
  void initState() {
    bloc = AppBloc();
    bloc!.add(GETPAYEMENTPERRECOVERY(recoveryId: selectedRecoveryId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
              bottom: 20,
              top: 15,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                ),
                30.widthBox,
                Text(
                  "Historique de paiement",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AppBloc, AppState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is LOADING) {
                  return const PaiementHistoricSqueletton();
                } else if (state is SUCCESS) {
                  List<PayementHistoric> payements = state.value;
                  return buidData(payements);
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  Widget buidData(List<PayementHistoric> payements) {
    return Expanded(
      child: Column(
        children: [
          30.heightBox,
          tabDetail(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    payements.length,
                    (index) => historicDetail(
                      context,
                      index: index,
                      payement: payements[index],
                    ),
                  ),
                  50.heightBox,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.SHADOW_COLOR.withAlpha(125),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.SHADOW_COLOR.withAlpha(125),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]),
                  child: Text(
                    "1",
                    style: GoogleFonts.montserrat(),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.SHADOW_COLOR.withAlpha(125),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
              ],
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
            SizedBox(
              width: 40,
              child: tabDetailModel(title: "#num"),
            ),
            30.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Date"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Libell??"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Montant"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Locataire"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Enregistrer par"),
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

  Widget historicDetail(
    BuildContext context, {
    int? index,
    required PayementHistoric payement,
  }) {
    double space = 10;

    DateTime paiedAt = DateTime.parse(payement.createdAt!);
    return OnHoverEffect(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailHistoric.routeName,
            arguments: payement,
          );
        },
        child: Container(
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
                flex: 1,
                child: suiteDetailModel(
                  title: CustomDate(date: paiedAt).getFullDate,
                ),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                    title: "${payement.contratData?.labelStr}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(title: "${payement.amount} USD"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                    title:
                        "${payement.contratData?.rentalContrat?.landlord?.name} ${payement.contratData?.rentalContrat?.landlord?.lastname}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                  title: "${payement.createdBy?.email}",
                ),
              ),
              space.widthBox,
              SizedBox(
                height: 30,
                width: 30,
                child: modelAction(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailHistoric.routeName,
                      arguments: payement,
                    );
                  },
                  icon: Iconsax.more,
                ),
              ),
            ],
          ),
        ),
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
