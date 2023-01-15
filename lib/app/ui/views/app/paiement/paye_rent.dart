import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/recovery/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/pop_pup.dart';
import 'package:bukara/app/ui/shared/utils/utility_functions.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/paiement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class PayeRent extends StatefulWidget {
  final ContratData contratData;
  const PayeRent({super.key, required this.contratData});

  @override
  State<PayeRent> createState() => _PayeRentState();
}

class _PayeRentState extends State<PayeRent> {
  PaiementController paiementController = PaiementController();
  AppBloc? bloc;
  @override
  void initState() {
    bloc = AppBloc();
    super.initState();
  }

  bool submitted = false;
  void submit() {
    isError.value = false;
    paiementController.rentalContratId = widget.contratData.rentalContrat!.id;
    if (paiementController.validation()) {
      paiementController.submit(bloc!);
      return;
    }
    setState(() {
      submitted = true;
    });
  }

  ValueNotifier<bool> isError = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is SUCCESS) {
          Navigator.pop(context, "success");
        } else if (state is ERROR) {
          errorModel(context, dueTo: state.dueTo!.errors!);
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
          bloc: bloc,
          builder: (context, state) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.all(15),
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Paiement loyer",
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
                      Text(
                        "Montant du",
                        style: GoogleFonts.montserrat(
                          color: AppColors.SECOND_TEXT_COLOR,
                          fontSize: 12,
                        ),
                      ),
                      5.heightBox,
                      Text(
                        "${restToPay(amount: widget.contratData.rentalContrat!.amount, paiements: widget.contratData.paiements)} USD",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
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
                                Text(
                                  "${widget.contratData.rentalContrat!.landlord!.name} ${widget.contratData.rentalContrat!.landlord!.lastname}",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                5.heightBox,
                                Text(
                                  "${widget.contratData.rentalContrat!.landlord!.email}",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.SECOND_TEXT_COLOR,
                                    fontSize: 12,
                                  ),
                                ),
                                10.heightBox,
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payer en",
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
                                  value:
                                      paiementController.selectedPaiementType,
                                  borderRadius: BorderRadius.circular(4),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                  ),
                                  underline: Container(),
                                  isDense: true,
                                  items: List.generate(
                                    paiementController.typePaiement.length,
                                    (index) =>
                                        paiementController.typePaiement[index],
                                  ).map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: SizedBox(
                                        width: 70,
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
                                      paiementController.selectedPaiementType =
                                          newValue!;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Montant payé",
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
                                      width: paiementController.amount.text
                                                  .trim()
                                                  .isEmpty &&
                                              submitted
                                          ? 1.5
                                          : 1,
                                      color: paiementController.amount.text
                                                  .trim()
                                                  .isEmpty &&
                                              submitted
                                          ? AppColors.RED_COLOR
                                          : AppColors.BORDER_COLOR,
                                    ),
                                  ),
                                  child: TextField(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                    controller: paiementController.amount,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      hintText: "Montent en \$",
                                      hintStyle: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (paiementController.selectedPaiementType == "bank")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.heightBox,
                            Text(
                              "Bordereau",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: AppColors.SECOND_TEXT_COLOR,
                              ),
                            ),
                            10.heightBox,
                            FormText(
                              width: 330,
                              controller: paiementController.transId,
                              hint: "Entrez le numero de bordereau",
                              submitted: submitted,
                            ),
                          ],
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                                              "Enregistrer",
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
                  ),
                ),
              ],
            );
          }),
    );
  }
}
