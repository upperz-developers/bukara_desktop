import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';
import 'package:bukara/app/ui/view_controller/enterprise_view_controller.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AddEditEnterpriseInfo extends StatefulWidget {
  final ValueNotifier<bool> isEdit;
  const AddEditEnterpriseInfo({super.key, required this.isEdit});

  @override
  State<AddEditEnterpriseInfo> createState() => _AddEditEnterpriseInfoState();
}

class _AddEditEnterpriseInfoState extends State<AddEditEnterpriseInfo> {
  double width = 220;
  double space = 50;
  double elementSpacer = 20;
  bool submitted = false;
  EnterpriseController enterpriseController = EnterpriseController();
  Enterprise enterprise = AuthController().enterpriseData.value;
  void editEnterprise() {
    if (enterpriseController.validated()) {
      enterpriseController.submit(context);
      return;
    }
    setState(() {
      submitted = true;
    });
  }

  @override
  void initState() {
    enterpriseController.designation.text = enterprise.designation ?? "";
    enterpriseController.idnat.text = enterprise.idnat ?? "";
    enterpriseController.impot.text = enterprise.impot ?? "";
    enterpriseController.rccm.text = enterprise.rccm ?? "";
    enterpriseController.contactController.email.text = enterprise.email ?? "";
    enterpriseController.contactController.internet.text =
        enterprise.site ?? "";
    if (enterprise.banks!.isNotEmpty) {
      enterpriseController.bankController.bankName.text =
          enterprise.banks?[0].bank ?? "";
      enterpriseController.bankController.accounName.text =
          enterprise.banks?[0].accountName ?? "";
      enterpriseController.bankController.accountNumber.text =
          enterprise.banks?[0].accountNumber ?? "";
    }
    enterpriseController.contactController.phoneNumber.text =
        enterprise.phones != null ? enterprise.phones!.substring(4) : "";

    if (enterprise.addresses!.isNotEmpty) {
      enterpriseController.addressController.country.text =
          enterprise.addresses?[0].country ?? "";

      enterpriseController.addressController.city.text =
          enterprise.addresses?[0].city ?? "";

      enterpriseController.addressController.town.text =
          enterprise.addresses?[0].town ?? "";

      enterpriseController.addressController.commune.text =
          enterprise.addresses![0].common ?? "";

      enterpriseController.addressController.quater.text =
          enterprise.addresses![0].quarter ?? "";
      enterpriseController.addressController.avenue.text =
          enterprise.addresses![0].street ?? "";
      enterpriseController.addressController.number.text =
          enterprise.addresses![0].number != null
              ? enterprise.addresses![0].number.toString()
              : "";
    }
    enterpriseController.description.text = enterprise.description ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AuthController().enterpriseData,
        builder: (context, Enterprise enterpriseData, child) {
          return Column(
            children: [
              Wrap(
                children: [
                  enterpriseModel(enterpriseData),
                  space.widthBox,
                  address(enterpriseData),
                  space.widthBox,
                  Column(
                    children: [
                      contact(enterpriseData),
                      10.heightBox,
                      bank(enterpriseData),
                    ],
                  ),
                  space.widthBox,
                  otherInfo(enterpriseData),
                ],
              ),
            ],
          );
        });
  }

  Widget enterpriseModel(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Entreprise",
        ),
        modelInfo(
          title: "Designation",
          hint: enterprise.designation != null
              ? enterprise.designation!
              : "Designation de l'entreprise",
          controller: enterpriseController.designation,
        ),
        modelInfo(
          title: "RCCM",
          hint: enterprise.rccm != null ? enterprise.rccm! : "RCCM-012973-GOM",
          controller: enterpriseController.rccm,
        ),
        modelInfo(
          title: "IDNAT",
          hint: enterprise.idnat != null
              ? enterprise.idnat!
              : "Numéro de l'indentification national",
          controller: enterpriseController.idnat,
        ),
        modelInfo(
          title: "Impot",
          hint: enterprise.impot != null ? enterprise.impot! : "Numéro impot",
          controller: enterpriseController.impot,
        ),
        Text(
          "Description",
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.SECOND_TEXT_COLOR,
            ),
          ),
        ),
        8.heightBox,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 250,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColors.BORDER_COLOR,
            ),
          ),
          child: TextField(
            controller: enterpriseController.description,
            style: GoogleFonts.montserrat(
              fontSize: 12,
            ),
            maxLines: 3,
            maxLength: 125,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: enterprise.description != null
                  ? enterprise.description!
                  : "Description de l'entreprise",
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget address(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Adresse",
        ),
        modelInfo(
          title: "Pays",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].country != null
              ? enterprise.addresses![0].country!
              : "Rep dem du congo",
          controller: enterpriseController.addressController.country,
        ),
        modelInfo(
          title: "Province",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].city != null
              ? enterprise.addresses![0].city!
              : "Nord-kivu",
          controller: enterpriseController.addressController.city,
        ),
        modelInfo(
          title: "Ville",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].town != null
              ? enterprise.addresses![0].town!
              : "Goma",
          controller: enterpriseController.addressController.town,
        ),
        modelInfo(
          title: "Commune",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].common != null
              ? enterprise.addresses![0].common!
              : "Goma",
          controller: enterpriseController.addressController.commune,
        ),
        modelInfo(
          title: "Quartier",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].quarter != null
              ? enterprise.addresses![0].quarter!
              : "Entrer le quartier",
          controller: enterpriseController.addressController.quater,
        ),
        modelInfo(
          title: "Avenue",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].street != null
              ? enterprise.addresses![0].street!
              : "Entrer l'avenu",
          controller: enterpriseController.addressController.avenue,
        ),
        modelInfo(
          title: "Numéro",
          hint: enterprise.addresses!.isNotEmpty &&
                  enterprise.addresses?[0].number != null
              ? enterprise.addresses![0].number.toString()
              : "Entrer le numéro",
          controller: enterpriseController.addressController.number,
        ),
      ],
    );
  }

  Widget contact(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Contact",
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Code",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.SECOND_TEXT_COLOR,
                  ),
                ),
              ),
              8.heightBox,
              Container(
                width: 250,
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColors.BORDER_COLOR,
                  ),
                ),
                child: CountryPickerDropdown(
                  isDense: true,
                  selectedItemBuilder: (country) => Text(
                    "+(${country.phoneCode}) - ${country.name.substring(0, country.name.length < 15 ? country.name.length : 15)}",
                    maxLines: 1,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                  ),
                  initialValue: 'CD',
                  itemBuilder: _buildDropdownItem,
                  priorityList: [
                    CountryPickerUtils.getCountryByIsoCode('CD'),
                    CountryPickerUtils.getCountryByIsoCode('CN'),
                  ],
                  sortComparator: (Country a, Country b) =>
                      a.isoCode.compareTo(b.isoCode),
                  onValuePicked: (Country country) {
                    enterpriseController.contactController.code =
                        country.phoneCode;
                  },
                ),
              ),
              Text(
                "Numéro",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.SECOND_TEXT_COLOR,
                  ),
                ),
              ),
              8.heightBox,
              FormText(
                hint: enterprise.phones != null
                    ? enterprise.phones!.substring(4)
                    : "097 000 000",
                submitted: submitted,
                controller: enterpriseController.contactController.phoneNumber,
              ),
            ],
          ),
        ),
        modelInfo(
          title: "Adresse mail",
          hint: enterprise.email != null
              ? enterprise.email!
              : "exemple@gmail.com",
          controller: enterpriseController.contactController.email,
        ),
        modelInfo(
          title: "Site internet",
          hint:
              enterprise.site != null ? enterprise.site! : "https://bukara.com",
          controller: enterpriseController.contactController.internet,
        ),
      ],
    );
  }

  Widget otherInfo(Enterprise enterprise) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OnHoverEffect(
                child: InkWell(
                  onTap: editEnterprise,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.BLACK_COLOR,
                    ),
                    child: Text(
                      "Modifier",
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
                        action: "Annuler",
                        action1: "Continuer",
                        body:
                            "Etes-vous sur de vouloir annuler? Si vous annuler l'opération les informations saisies seront effacées",
                        onTap1: () {
                          Navigator.pop(context);
                        },
                        head: "Annuler l'opération",
                        onTap: () {
                          Navigator.pop(context);
                          widget.isEdit.value = false;
                        });
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.DISABLE_COLOR,
                    ),
                    child: Text(
                      "Annuler",
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
        ],
      ),
    );
  }

  Widget bank(Enterprise enterprise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Compte bancaire",
        ),
        modelInfo(
          title: "Banque",
          hint:
              enterprise.banks!.isNotEmpty && enterprise.banks?[0].bank != null
                  ? enterprise.banks![0].bank!
                  : "Votre banque",
          controller: enterpriseController.bankController.bankName,
        ),
        modelInfo(
          title: "Nom de compte",
          hint: enterprise.banks!.isNotEmpty &&
                  enterprise.banks?[0].accountName != null
              ? enterprise.banks![0].accountName!
              : "Le nom de compte de votre banque",
          controller: enterpriseController.bankController.accounName,
        ),
        modelInfo(
          title: "Numéro de compte",
          hint: enterprise.banks!.isNotEmpty &&
                  enterprise.banks?[0].accountNumber != null
              ? enterprise.banks![0].accountNumber!
              : "0000 0000 0000 0000 0000 000",
          controller: enterpriseController.bankController.accountNumber,
        ),
      ],
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

  Widget _buildDropdownItem(Country country) => Text(
        "+${country.phoneCode}(${country.name})",
        style: GoogleFonts.montserrat(
          fontSize: 14,
        ),
      );

  Widget modelInfo(
      {String? title,
      String? hint,
      TextEditingController? controller,
      bool? optinal}) {
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
          FormText(
            hint: hint,
            optinal: optinal,
            controller: controller,
            submitted: submitted,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    enterpriseController.dispose();
    super.dispose();
  }
}
