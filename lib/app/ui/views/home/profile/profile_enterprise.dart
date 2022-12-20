import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:bukara/app/ui/views/start/shared/utils/hover_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileEnterprise extends StatefulWidget {
  final ValueNotifier<bool> isEdit;
  final Enterprise enterprise;
  const ProfileEnterprise(
      {super.key, required this.isEdit, required this.enterprise});

  @override
  State<ProfileEnterprise> createState() => _ProfileEnterpriseState();
}

class _ProfileEnterpriseState extends State<ProfileEnterprise> {
  double width = 220;
  double space = 50;
  double elementSpacer = 20;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: space,
      children: [
        SizedBox(
          width: width,
          child: entrepriseInfo(),
        ),
        SizedBox(
          width: width,
          child: addressInfo(),
        ),
        SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contactInfo(),
              elementSpacer.heightBox,
              supportInfo(),
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
            ],
          ),
        ),
        userInfo(),
      ],
    );
  }

  Widget entrepriseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Entreprise"),
        modelInfo(title: "Nom", info: widget.enterprise.designation),
        modelInfo(
          title: "description",
          info: widget.enterprise.description,
        ),
        modelInfo(
          title: "RCCM",
          info: widget.enterprise.rccm,
        ),
        modelInfo(
          title: "IDNAT",
          info: widget.enterprise.idnat,
        ),
        modelInfo(
          title: "Impot",
          info: widget.enterprise.impot,
        ),
      ],
    );
  }

  Widget supportInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Support"),
        modelInfo(
          title: "Banque",
          info: widget.enterprise.banks!.isNotEmpty
              ? widget.enterprise.banks![0].bank
              : null,
        ),
        modelInfo(
          title: "Nom du compte",
          info: widget.enterprise.banks!.isNotEmpty
              ? widget.enterprise.banks![0].accountName
              : null,
        ),
        modelInfo(
          title: "numero du compte",
          info: widget.enterprise.banks!.isNotEmpty
              ? widget.enterprise.banks![0].accountNumber
              : null,
        ),
      ],
    );
  }

  Widget contactInfo() {
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

  Widget addressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Address"),
        modelInfo(
          title: "Reference",
          info: widget.enterprise.addresses!.isNotEmpty
              ? widget.enterprise.addresses![0].reference
              : null,
        ),
        modelInfo(
            title: "Pays",
            info: widget.enterprise.addresses!.isNotEmpty
                ? widget.enterprise.addresses![0].country
                : null),
        modelInfo(
            title: "Province",
            info: widget.enterprise.addresses!.isNotEmpty
                ? widget.enterprise.addresses![0].city
                : null),
        modelInfo(
          title: "Ville",
          info: widget.enterprise.addresses!.isNotEmpty
              ? widget.enterprise.addresses![0].town
              : null,
        ),
        modelInfo(
            title: "Quartier",
            info: widget.enterprise.addresses!.isNotEmpty
                ? widget.enterprise.addresses![0].quarter
                : null),
        modelInfo(
            title: "Avenue",
            info: widget.enterprise.addresses!.isNotEmpty
                ? widget.enterprise.addresses![0].street
                : null),
        modelInfo(
            title: "Numero",
            info: widget.enterprise.addresses!.isNotEmpty
                ? widget.enterprise.addresses![0].number.toString()
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
              Container(
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
                fontSize: 11,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ),
          5.heightBox,
          Text(
            info ?? "Pas defini",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 13,
              ),
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
