import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:bukara/app/ui/views/start/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/views/start/shared/widget.dart';
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            enterprise(),
            space.widthBox,
            address(),
            space.widthBox,
            Column(
              children: [
                contact(),
                10.heightBox,
                bank(),
              ],
            ),
            space.widthBox,
            otherInfo(),
          ],
        ),
      ],
    );
  }

  Widget enterprise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Entreprise",
        ),
        modelInfo(
          title: "Designation",
          hint: "Designation de l'entreprise",
          controller: enterpriseController.designation,
        ),
        modelInfo(
          title: "RCCM",
          hint: "RCCM-012973-GOM",
          controller: enterpriseController.rccm,
        ),
        modelInfo(
          title: "IDNAT",
          hint: "Numero de l'indentification national",
          controller: enterpriseController.idnat,
        ),
        modelInfo(
          title: "Impot",
          hint: "Numero impot",
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
              hintText: "Description de l'entreprise",
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Adresse",
        ),
        modelInfo(
          title: "Reference",
          hint: "Entrez la reference",
          controller: enterpriseController.addressController.reference,
        ),
        modelInfo(
          title: "Pays",
          hint: "Rep dem du congo",
          controller: enterpriseController.addressController.country,
        ),
        modelInfo(
          title: "Province",
          hint: "Nord-kivu",
          controller: enterpriseController.addressController.city,
        ),
        modelInfo(
          title: "Ville",
          hint: "Goma",
          controller: enterpriseController.addressController.town,
        ),
        modelInfo(
          title: "Commune",
          hint: "Goma",
          controller: enterpriseController.addressController.commune,
        ),
        modelInfo(
          title: "Quartier",
          hint: "Entrer le cartier",
          controller: enterpriseController.addressController.quater,
        ),
        modelInfo(
          title: "Avenue",
          hint: "Entrer l'avenu",
          controller: enterpriseController.addressController.avenue,
        ),
        modelInfo(
          title: "Numero",
          hint: "Entrer le numero",
          controller: enterpriseController.addressController.number,
        ),
      ],
    );
  }

  Widget contact() {
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
                "Numero",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: AppColors.SECOND_TEXT_COLOR,
                  ),
                ),
              ),
              8.heightBox,
              FormText(
                hint: "097 000 000",
                submitted: submitted,
                controller: enterpriseController.contactController.phoneNumber,
              ),
            ],
          ),
        ),
        modelInfo(
          title: "Adresse mail",
          hint: "exemple@gmail.com",
          controller: enterpriseController.contactController.email,
        ),
        modelInfo(
          title: "Site internet",
          hint: "https://bukara.com",
          controller: enterpriseController.contactController.internet,
        ),
      ],
    );
  }

  Widget otherInfo() {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Logo",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ),
          8.heightBox,
          OnHoverEffect(
            child: InkWell(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          30.heightBox,
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
                    widget.isEdit.value = false;
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

  Widget bank() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTitle(
          "Compte bancaire",
        ),
        modelInfo(
          title: "Banque",
          hint: "Votre banque",
          controller: enterpriseController.bankController.bankName,
        ),
        modelInfo(
          title: "Nom de compte",
          hint: "Le nom de compte de votre banque",
          controller: enterpriseController.bankController.accounName,
        ),
        modelInfo(
          title: "Numero de compte",
          hint: "0000 0000 0000 0000 0000 000",
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
