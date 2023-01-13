import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';
import 'package:bukara/app/ui/views/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileEnterprise extends StatefulWidget {
  final ValueNotifier<bool> isEdit;

  const ProfileEnterprise({
    super.key,
    required this.isEdit,
  });

  @override
  State<ProfileEnterprise> createState() => _ProfileEnterpriseState();
}

class _ProfileEnterpriseState extends State<ProfileEnterprise> {
  double width = 220;
  double space = 50;
  double elementSpacer = 20;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthController().enterpriseData,
      builder: (context, Enterprise enterprise, child) {
        return Wrap(
          spacing: space,
          children: [
            SizedBox(
              width: width,
              child: entrepriseInfo(enterprise),
            ),
            SizedBox(
              width: width,
              child: addressInfo(enterprise),
            ),
            SizedBox(
              width: width,
              child: contactInfo(enterprise),
            ),
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  supportInfo(enterprise),
                  elementSpacer.heightBox,
                  OnHoverEffect(
                    child: InkWell(
                      onTap: () {
                        widget.isEdit.value = true;
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        width: width,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.BLACK_COLOR,
                        ),
                        child: Text(
                          "Modifier entreprise",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.WHITE_COLOR,
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.heightBox,
                  OnHoverEffect(
                    child: InkWell(
                      onTap: () {
                        alertMessage(context,
                            body:
                                "Voulez-vous vraiment vous deconnecter de cette application?",
                            action1: "Annuler",
                            head: "Deconnexion",
                            action: "Se deconnecter", onTap: () {
                          AppPref.prefs!.clear();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Auth.routeName, (route) => false);
                        }, onTap1: () {
                          Navigator.pop(context);
                        });
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        width: width,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.DISABLE_COLOR,
                        ),
                        child: Text(
                          "Se deconnecter",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.BLACK_COLOR,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget entrepriseInfo(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Entreprise"),
        modelInfo(title: "Nom", info: enterprise.designation),
        modelInfo(
          title: "description",
          info: enterprise.description,
        ),
        modelInfo(
          title: "RCCM",
          info: enterprise.rccm,
        ),
        modelInfo(
          title: "IDNAT",
          info: enterprise.idnat,
        ),
        modelInfo(
          title: "Impot",
          info: enterprise.impot,
        ),
      ],
    );
  }

  Widget supportInfo(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Support"),
        modelInfo(
          title: "Banque",
          info: enterprise.banks!.isNotEmpty ? enterprise.banks![0].bank : null,
        ),
        modelInfo(
          title: "Nom du compte",
          info: enterprise.banks!.isNotEmpty
              ? enterprise.banks![0].accountName
              : null,
        ),
        modelInfo(
          title: "numéro du compte",
          info: enterprise.banks!.isNotEmpty
              ? enterprise.banks![0].accountNumber
              : null,
        ),
      ],
    );
  }

  Widget contactInfo(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Contact"),
        modelInfo(title: "Telephone", info: "+243 (0) 970 000 000"),
        modelInfo(
          title: "email",
          info: "contact@bukara.com",
        ),
        modelInfo(
          title: "Site internet",
          info: "https://bukara.com",
        ),
      ],
    );
  }

  Widget addressInfo(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Address"),
        modelInfo(
            title: "Pays",
            info: enterprise.addresses!.isNotEmpty
                ? enterprise.addresses![0].country
                : null),
        modelInfo(
            title: "Province",
            info: enterprise.addresses!.isNotEmpty
                ? enterprise.addresses![0].city
                : null),
        modelInfo(
          title: "Ville",
          info: enterprise.addresses!.isNotEmpty
              ? enterprise.addresses![0].town
              : null,
        ),
        modelInfo(
          title: "Commune",
          info: enterprise.addresses!.isNotEmpty
              ? enterprise.addresses![0].common
              : null,
        ),
        modelInfo(
            title: "Quartier",
            info: enterprise.addresses!.isNotEmpty
                ? enterprise.addresses![0].quarter
                : null),
        modelInfo(
            title: "Avenue",
            info: enterprise.addresses!.isNotEmpty
                ? enterprise.addresses![0].street
                : null),
        modelInfo(
            title: "Numéro",
            info: enterprise.addresses!.isNotEmpty
                ? enterprise.addresses![0].number.toString()
                : null),
      ],
    );
  }

  Widget userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Utilisateur"),
        Container(
          padding: const EdgeInsets.all(15),
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.WHITE_COLOR,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              modelInfo(title: "Nom", info: "Admin"),
              modelInfo(title: "Post-nom", info: "Other name"),
              modelInfo(title: "contact", info: "+243 (0) 970 000 000"),
              modelInfo(title: "email", info: "admin@bukara.com"),
              modelInfo(title: "Adresse", info: "full home address"),
              20.heightBox,
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                width: width,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.DISABLE_COLOR,
                ),
                child: Text(
                  "Modifier",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              OnHoverEffect(
                child: InkWell(
                  onTap: () {
                    AppPref.prefs!.clear();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Auth.routeName, (route) => false);
                  },
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.BLACK_COLOR,
                    ),
                    child: Text(
                      "Se deconnecter",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.WHITE_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget otherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Autres informations"),
        Text(
          "Sceau",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.SECOND_TEXT_COLOR,
            ),
          ),
        ),
        10.heightBox,
      ],
    );
  }

  Widget modelInfo({String? title, String? info}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 10,
                height: 1.5,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ),
          5.heightBox,
          Text(
            info ?? "Pas defini",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
