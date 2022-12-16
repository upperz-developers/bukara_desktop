import 'package:bukara/app/ui/shared/style.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double width = 220;
  double space = 50;
  double elementSpacer = 20;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        children: [
          appTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: space,
                children: [
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        entrepriseInfo(),
                        elementSpacer.heightBox,
                        supportInfo(),
                      ],
                    ),
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
                        Container(
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
                      ],
                    ),
                  ),
                  userInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appTitle() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 220,
              right: 50,
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.WHITE_COLOR,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Profile entreprise",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      3.heightBox,
                      Text(
                        "Bukara Sarl",
                        style: GoogleFonts.montserrat(
                          color: AppColors.SECOND_TEXT_COLOR,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.DISABLE_COLOR,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        mat.Icons.person,
                        color: mat.Colors.black54,
                      ),
                    ),
                    10.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Current user",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                          ),
                        ),
                        3.heightBox,
                        Text(
                          "admin@gmail.com",
                          style: GoogleFonts.montserrat(
                            color: AppColors.SECOND_TEXT_COLOR,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 5,
                  color: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
                ),
                color: AppColors.WHITE_COLOR,
                image: const DecorationImage(
                  image: AssetImage("assets/icons/bukara.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget entrepriseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Entreprise"),
        modelInfo(title: "Nom", info: "Bukara"),
        modelInfo(
          title: "description",
          info: "This is the description of the enterprise",
        ),
      ],
    );
  }

  Widget supportInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Support"),
        modelInfo(title: "Nom du compte", info: "Bukara sarl"),
        modelInfo(
          title: "numero du compte",
          info: "0000 0000 0000 0000 0000 000",
        ),
        modelInfo(
          title: "Code Swift",
          info: "BnkSCode",
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
          info: "Une reference de l'adresse de l'entreprise",
        ),
        modelInfo(title: "Pays", info: "Congo/kinshasa"),
        modelInfo(title: "Province", info: "Nord-kivu"),
        modelInfo(title: "Ville", info: "Goma"),
        modelInfo(title: "Quartier", info: "Himbi 2"),
        modelInfo(title: "Avenue", info: "Avenue"),
        modelInfo(title: "Numero", info: "2"),
      ],
    );
  }

  Widget userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle("Informations utilisateurs"),
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
                fontSize: 12,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ),
          8.heightBox,
          Text(
            info!,
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
