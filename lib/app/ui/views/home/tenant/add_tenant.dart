import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/view_controller/tenant_controller.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTenants extends StatefulWidget {
  const AddTenants({super.key});

  @override
  State<AddTenants> createState() => _AddTenantsState();
}

class _AddTenantsState extends State<AddTenants> {
  TenantController tenantController = TenantController();
  AppBloc? _bloc;
  bool submitted = false;

  @override
  void initState() {
    _bloc = AppBloc();
    super.initState();
  }

  void submit() {
    if (tenantController.addValidation()) {
      tenantController.submit(_bloc!);
      return;
    }
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SUCCESS) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
          bloc: _bloc,
          builder: (context, state) {
            return IgnorePointer(
              ignoring: state is LOADING,
              child: SimpleDialog(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 290,
                    width: 525,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Ajouter un locataire",
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            15.widthBox,
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.DISABLE_COLOR,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Wrap(
                              spacing: 30,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nom",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint: "Entrez le nom",
                                      controller: tenantController.firstName,
                                      submitted: submitted,
                                    ),
                                    20.heightBox,
                                    Text(
                                      "Postnom",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint: "Entrez le postnom",
                                      controller: tenantController.lastname,
                                      submitted: submitted,
                                    ),
                                    20.heightBox,
                                    Text(
                                      "Adress mail",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint: "Entrez l'adresse mail",
                                      controller: tenantController.email,
                                      submitted: submitted,
                                    ),
                                    20.heightBox,
                                    Text(
                                      "Adress physique",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint:
                                          "Entrez le dernier adresse du locataire",
                                      controller: tenantController.lastAddress,
                                      submitted: submitted,
                                    ),
                                    20.heightBox,
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Type de carte d'indentite",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.SECOND_TEXT_COLOR,
                                              ),
                                            ),
                                          ),
                                          8.heightBox,
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.BORDER_COLOR,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              value: tenantController
                                                  .selectedCardType,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 20,
                                              ),
                                              underline: Container(),
                                              isDense: true,
                                              items: List.generate(
                                                  tenantController
                                                      .cartType.length,
                                                  (index) => tenantController
                                                      .cartType[index]).map(
                                                  (String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    width: 208,
                                                    child: Text(
                                                      items,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  tenantController
                                                          .selectedCardType =
                                                      newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Numero carte",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint:
                                          "Entrez le numero de la carte d'indentite",
                                      controller: tenantController.cartId,
                                      submitted: submitted,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nationalite",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    8.heightBox,
                                    FormText(
                                      hint:
                                          "Entrez la nationnalite du locataire",
                                      controller: tenantController.nationalite,
                                      submitted: submitted,
                                    ),
                                    20.heightBox,
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Type de locataire",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.SECOND_TEXT_COLOR,
                                              ),
                                            ),
                                          ),
                                          8.heightBox,
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.BORDER_COLOR,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              value: tenantController
                                                  .selectedTenantType,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 20,
                                              ),
                                              underline: Container(),
                                              isDense: true,
                                              items: List.generate(
                                                  tenantController
                                                      .tenantType.length,
                                                  (index) => tenantController
                                                      .tenantType[index]).map(
                                                  (String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    width: 208,
                                                    child: Text(
                                                      items,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  tenantController
                                                          .selectedTenantType =
                                                      newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Etat civil",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.SECOND_TEXT_COLOR,
                                              ),
                                            ),
                                          ),
                                          8.heightBox,
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.BORDER_COLOR,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              value: tenantController
                                                  .selectedTenantCivilState,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                size: 20,
                                              ),
                                              underline: Container(),
                                              isDense: true,
                                              items: List.generate(
                                                  tenantController
                                                      .tenantCivilState.length,
                                                  (index) => tenantController
                                                          .tenantCivilState[
                                                      index]).map(
                                                  (String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: SizedBox(
                                                    width: 208,
                                                    child: Text(
                                                      items,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  tenantController
                                                          .selectedTenantCivilState =
                                                      newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Numero telephone",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                      ),
                                    ),
                                    10.heightBox,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Code",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                            ),
                                          ),
                                        ),
                                        8.heightBox,
                                        Container(
                                          width: 250,
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: AppColors.BORDER_COLOR,
                                            ),
                                          ),
                                          child: CountryPickerDropdown(
                                            isDense: true,
                                            selectedItemBuilder: (country) =>
                                                Text(
                                              "+(${country.phoneCode}) - ${country.name.substring(0, country.name.length < 15 ? country.name.length : 15)}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                              ),
                                            ),
                                            initialValue: 'CD',
                                            itemBuilder: _buildDropdownItem,
                                            priorityList: [
                                              CountryPickerUtils
                                                  .getCountryByIsoCode('CD'),
                                              CountryPickerUtils
                                                  .getCountryByIsoCode('CN'),
                                            ],
                                            sortComparator: (Country a,
                                                    Country b) =>
                                                a.isoCode.compareTo(b.isoCode),
                                            onValuePicked: (Country country) {
                                              tenantController.countryCode =
                                                  country.phoneCode;
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Numero",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColors.SECOND_TEXT_COLOR,
                                            ),
                                          ),
                                        ),
                                        8.heightBox,
                                        FormText(
                                          hint: "097 000 000",
                                          controller:
                                              tenantController.phoneNumber,
                                          submitted: submitted,
                                        ),
                                      ],
                                    ),
                                    30.heightBox,
                                    CustomButton(
                                      title: "Enregistrer",
                                      backgroundColor: AppColors.BLACK_COLOR,
                                      textColor: AppColors.WHITE_COLOR,
                                      onTap: submit,
                                      state: state,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildDropdownItem(Country country) => Text(
        "+${country.phoneCode}(${country.name})",
        style: GoogleFonts.montserrat(
          fontSize: 14,
        ),
      );
}
