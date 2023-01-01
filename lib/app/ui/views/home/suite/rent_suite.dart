import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/rent_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class RentSuite extends StatefulWidget {
  final TenantModel tenantModel;
  const RentSuite({super.key, required this.tenantModel});

  @override
  State<RentSuite> createState() => _RentSuiteState();
}

class _RentSuiteState extends State<RentSuite> {
  RentController rentController = RentController();
  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                      items: List.generate(12, (index) => "${index + 1} mois")
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
                          rentController.selectedMonth =
                              newValue!.substring(0, newValue.indexOf(" "));
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
                    controller: TextEditingController(),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                      items: List.generate(10, (index) => "${index + 1}")
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
                          rentController.selectedRentAccount = newValue!;
                        });
                      },
                    ),
                  )
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
              child: OnHoverEffect(
                child: InkWell(
                  onTap: () {},
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
                    child: Text("Enregistre",
                        style: GoogleFonts.montserrat(
                          color: AppColors.WHITE_COLOR,
                          fontWeight: FontWeight.bold,
                        )),
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
  }
}
