import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/no_data.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/squeletton/paiement_squeletton.dart';
import 'package:bukara/app/ui/views/app/paiement/detail_historic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowPaiementHistoric extends StatefulWidget {
  final TextEditingController? search;
  const ShowPaiementHistoric({super.key, this.search});

  @override
  State<ShowPaiementHistoric> createState() => _ShowPaiementHistoricState();
}

class _ShowPaiementHistoricState extends State<ShowPaiementHistoric> {
  AppBloc? bloc;
  @override
  void initState() {
    widget.search!.addListener(searchListener);
    bloc = AppBloc();
    bloc!.add(GETPAYEMENT());
    super.initState();
  }

  bool isSearch = false;
  List<PayementHistoric> searchPaiement = [];
  List<PayementHistoric> payements = [];
  void searchListener() {
    setState(() {
      isSearch = widget.search!.text.isNotEmpty;
      if (isSearch) {
        searchPaiement = payements
            .where((p) =>
                p.contratData!.rentalContrat!.landlord!.name!
                    .toLowerCase()
                    .contains(widget.search!.text.toLowerCase()) ||
                p.contratData!.rentalContrat!.landlord!.lastname!
                    .toLowerCase()
                    .contains(widget.search!.text.toLowerCase()) ||
                p.contratData!.rentalContrat!.landlord!.email!
                    .toLowerCase()
                    .contains(widget.search!.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    widget.search!.removeListener(searchListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LOADING) {
            return const PaiementHistoricSqueletton();
          } else if (state is SUCCESS) {
            payements = state.value;
            return buidData(isSearch ? searchPaiement : payements);
          } else if (state is ERROR) {
            return NoData(
              dueTo: state.dueTo!.errors!,
              onTap: () {
                bloc!.add(GETPAYEMENT());
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        });
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
              child: tabDetailModel(title: "Libellé"),
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
                    title: "${payement.contratData!.labelStr}"),
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
                        "${payement.contratData!.rentalContrat!.landlord!.name} ${payement.contratData!.rentalContrat!.landlord!.lastname}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(
                  title: "${payement.createdBy!.email}",
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
