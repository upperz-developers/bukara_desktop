import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/rent_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class RentSuite extends StatefulWidget {
  final TenantModel tenantModel;
  final String suiteId;
  const RentSuite(
      {super.key, required this.tenantModel, required this.suiteId});

  @override
  State<RentSuite> createState() => _RentSuiteState();
}

class _RentSuiteState extends State<RentSuite> {
  AppBloc? bloc;

  @override
  void initState() {
    bloc = AppBloc();
    super.initState();
  }

  bool submitted = false;

  RentController rentController = RentController();
  ValueNotifier<bool> isError = ValueNotifier(false);
  void submit() {
    isError.value = false;
    rentController.selectedSuiteId = widget.suiteId;
    rentController.selectedTenantId = widget.tenantModel.id;
    if (rentController.validate()) {
      rentController.submit(bloc!);
      return;
    }
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      bloc: bloc,
      listener: ((context, state) {
        if (state is SUCCESS) {
          Navigator.pop(context);
        } else if (state is ERROR) {
          isError.value = true;
        }
      }),
      child: BlocBuilder<AppBloc, AppState>(
          bloc: bloc,
          builder: (context, state) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.all(30),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Louer l'appartement",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    15.widthBox,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                30.heightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.DISABLE_COLOR,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.user,
                      ),
                    ),
                    15.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text:
                                  "${widget.tenantModel.name} ${widget.tenantModel.lastname}",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: " - ",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${widget.tenantModel.phones?[0].countryCode} (0) ${widget.tenantModel.phones?[0].number}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: AppColors.SECOND_TEXT_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          5.heightBox,
                          Text(
                            "${widget.tenantModel.landlordType}",
                            style: GoogleFonts.montserrat(
                              color: AppColors.SECOND_TEXT_COLOR,
                              fontSize: 12,
                            ),
                          ),
                          10.heightBox,
                          Text(
                            "${widget.tenantModel.lastAdress}",
                            style: GoogleFonts.montserrat(
                              color: AppColors.SECOND_TEXT_COLOR,
                              fontSize: 12,
                            ),
                          ),
                          10.heightBox,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.DISABLE_COLOR,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "${widget.tenantModel.maritalStatus}",
                              style: GoogleFonts.montserrat(
                                color: AppColors.SECOND_TEXT_COLOR,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                            "Mois",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: AppColors.SECOND_TEXT_COLOR,
                            ),
                          ),
                          10.heightBox,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 1,
                                color: AppColors.BORDER_COLOR,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: rentController.selectedMonthUI,
                              borderRadius: BorderRadius.circular(4),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                              ),
                              underline: Container(),
                              isDense: true,
                              items: List.generate(
                                      12, (index) => "${index + 1} mois")
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: SizedBox(
                                    width: 60,
                                    child: Text(
                                      items,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  rentController.selectedMonth = newValue!
                                      .substring(0, newValue.indexOf(" "));
                                  rentController.selectedMonthUI = newValue;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prix par mois",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: AppColors.SECOND_TEXT_COLOR,
                            ),
                          ),
                          10.heightBox,
                          FormText(
                            width: 100,
                            hint: "1 USD",
                            submitted: submitted,
                            controller: rentController.price,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personnes",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: AppColors.SECOND_TEXT_COLOR,
                            ),
                          ),
                          10.heightBox,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 1,
                                color: AppColors.BORDER_COLOR,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: rentController.selectedRentAccount,
                              borderRadius: BorderRadius.circular(4),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                              ),
                              underline: Container(),
                              isDense: true,
                              items:
                                  List.generate(10, (index) => "${index + 1}")
                                      .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: SizedBox(
                                    width: 60,
                                    child: Text(
                                      items,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  rentController.selectedRentAccount =
                                      newValue!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: isError,
                    builder: (context, bool isErrorValue, child) {
                      String? error;
                      if (state is ERROR) {
                        error = state.dueTo;
                      }
                      return isErrorValue
                          ? Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.only(
                                          left: 14,
                                          top: 10,
                                          bottom: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.WHITE_COLOR,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: AppColors.BOXSHADOW
                                                .withAlpha(125),
                                            offset: const Offset(0, 3),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Erreur",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              15.widthBox,
                                              InkWell(
                                                onTap: () {
                                                  isError.value = false;
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.heightBox,
                                          Text(
                                            error!,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 4,
                                        decoration: const BoxDecoration(
                                          color: AppColors.RED_COLOR,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OnHoverEffect(
                        child: InkWell(
                          onTap: submit,
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.BLACK_COLOR,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                state is LOADING
                                    ? const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          color: AppColors.WHITE_COLOR,
                                        ),
                                      )
                                    : Text(
                                        "Enregistre",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.WHITE_COLOR,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    15.widthBox,
                    Expanded(
                      child: OnHoverEffect(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: AppColors.DISABLE_COLOR,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
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
            );
          }),
    );
  }
}
