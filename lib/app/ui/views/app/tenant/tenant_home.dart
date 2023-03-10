import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/utils/no_data.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/squeletton/tenant_squeletton.dart';
import 'package:bukara/app/ui/views/app/tenant/add_tenant.dart';
import 'package:bukara/shared/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class Tenant extends StatefulWidget {
  const Tenant({super.key});

  @override
  State<Tenant> createState() => _Tenant();
}

class _Tenant extends State<Tenant> {
  ValueNotifier<bool> isShowTenant = ValueNotifier(false);
  TenantModel? selectedTenant;
  AppBloc? _bloc;

  TextEditingController? search;

  @override
  void initState() {
    isEditTenant = false;
    search = TextEditingController()..addListener(searchListener);
    _bloc = AppBloc();
    _bloc!.add(GETTENANT());
    super.initState();
  }

  @override
  void dispose() {
    search!.removeListener(searchListener);
    super.dispose();
  }

  List<TenantModel> tenants = [];
  List<TenantModel> searchTenant = [];
  bool isSearch = false;
  void searchListener() {
    setState(() {
      isSearch = search!.text.isNotEmpty;
      if (isSearch) {
        searchTenant = tenants
            .where(
              (t) =>
                  t.name!.toLowerCase().contains(
                        search!.text.trim().toLowerCase(),
                      ) ||
                  t.lastname!.toLowerCase().contains(
                        search!.text.trim().toLowerCase(),
                      ) ||
                  t.email!.toLowerCase().contains(
                        search!.text.trim().toLowerCase(),
                      ) ||
                  t.phones![0].number!.toLowerCase().contains(
                        search!.text.trim().toLowerCase(),
                      ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustormScaffoldPage(
      onSuccess: () {},
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: horizontalSpace,
              right: horizontalSpace,
              bottom: 20,
              top: 15,
            ),
            child: appBar(context, title: "Locataires"),
          ),
          Expanded(
            child: BlocBuilder<AppBloc, AppState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is LOADING) {
                  return const TenantSqueletton();
                }

                if (state is SUCCESS) {
                  tenants = state.value;
                  return buidData(isSearch ? searchTenant : tenants);
                } else if (state is ERROR) {
                  return NoData(
                    dueTo: state.dueTo!.errors!,
                    onTap: () {
                      _bloc!.add(GETTENANT());
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buidData(List<TenantModel> tenants) {
    return Column(
      children: [
        infoTabBar(),
        30.heightBox,
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: isShowTenant,
            builder: (context, bool isShowDetail, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          tabDetail(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  tenants.length,
                                  (index) => tenantDetail(
                                    index: index,
                                    tenant: tenants[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    30.widthBox,
                    Container(
                      width: isShowDetail ? 320 : 0,
                      height: 590,
                      decoration: BoxDecoration(
                        color: AppColors.WHITE_COLOR,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isShowDetail
                          ? showTenantDetail()
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget showTenantDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              modelAction(
                  icon: Iconsax.edit,
                  onTap: () {
                    isEditTenant = true;
                    showDialog(
                      context: context,
                      builder: (context) => AddTenants(
                        tenant: selectedTenant,
                      ),
                      barrierDismissible: false,
                    ).then((value) {
                      if (value == "success") {
                        _bloc!.add(GETTENANT());
                      }
                    });
                  }),
              15.widthBox,
              modelAction(
                  icon: Icons.close,
                  onTap: () {
                    isShowTenant.value = false;
                  }),
            ],
          ),
          25.heightBox,
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${selectedTenant!.name} ${selectedTenant!.lastname}",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${selectedTenant!.landlordType}",
                    style: GoogleFonts.montserrat(
                      color: AppColors.BLACK_COLOR,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(),
                  ),
                  Text(
                    "?? propos du locataire",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  25.heightBox,
                  if (selectedTenant!.phones!.isNotEmpty)
                    module(Iconsax.call,
                        "${selectedTenant!.phones![0].countryCode} (0) ${selectedTenant!.phones![0].number}"),
                  module(Iconsax.box_tick, "${selectedTenant!.email}"),
                  module(Iconsax.home, "${selectedTenant!.maritalStatus}"),
                  module2(
                      Iconsax.tag, "Adresse", "${selectedTenant!.lastAdress}"),
                  module(
                      Iconsax.wallet_check, "${selectedTenant!.nationality}"),
                  module2(Iconsax.tag, "${selectedTenant!.cardTypeId}",
                      "${selectedTenant!.cardType}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget module(
    IconData? icon,
    String? message,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child: Text(
              "$message",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget module2(IconData? icon, String? title, String? message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "$title",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "$message",
                style: GoogleFonts.montserrat(
                  color: AppColors.SECOND_TEXT_COLOR,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget tabDetail() {
    double space = 10;
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 30,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: tabDetailModel(title: "#Num."),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Responsable"),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Type de locataire"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Etat civile"),
            ),
            space.widthBox,
            Expanded(
              flex: 3,
              child: tabDetailModel(title: "Adresse physique"),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Contact"),
            ),
            space.widthBox,
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "Plus"),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalSpace,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.DISABLE_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OnHoverEffect(
            child: InkWell(
              onTap: () {
                isEditTenant == false;
                showDialog(
                  context: context,
                  builder: (context) => const AddTenants(),
                  barrierDismissible: false,
                ).then((value) {
                  if (value == "success") {
                    _bloc!.add(GETTENANT());
                  }
                });
              },
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: AppColors.BLACK_COLOR,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Iconsax.add,
                  color: AppColors.WHITE_COLOR,
                ),
              ),
            ),
          ),
          15.widthBox,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.BORDER_COLOR,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                    controller: search,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Tapez un mot cl??",
                        helperStyle: GoogleFonts.montserrat(
                          fontSize: 12,
                        )),
                  ),
                ),
                10.widthBox,
                const Icon(
                  Iconsax.search_normal,
                  color: AppColors.SECOND_TEXT_COLOR,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tenantDetail({
    int? index,
    required TenantModel tenant,
  }) {
    double space = 10;
    return OnHoverEffect(
      child: InkWell(
        onTap: () {
          isShowTenant.value = false;
          isShowTenant.value = true;
          selectedTenant = tenant;
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
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
                width: 50,
                child: suiteDetailModel(
                  title: "00${index + 1}",
                ),
              ),
              space.widthBox,
              Expanded(
                flex: 2,
                child: suiteDetailModel(
                    title: "${tenant.name} ${tenant.lastname}"),
              ),
              space.widthBox,
              Expanded(
                flex: 2,
                child: suiteDetailModel(title: "${tenant.landlordType}"),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: suiteDetailModel(title: "${tenant.maritalStatus}"),
              ),
              space.widthBox,
              Expanded(
                flex: 3,
                child: suiteDetailModel(title: "${tenant.lastAdress}"),
              ),
              space.widthBox,
              Expanded(
                flex: 2,
                child: tenant.phones!.isNotEmpty
                    ? suiteDetailModel(
                        title:
                            "${tenant.phones![0].countryCode} (0) ${tenant.phones![0].number}")
                    : const SizedBox.shrink(),
              ),
              space.widthBox,
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    modelAction(
                      onTap: () {
                        isShowTenant.value = false;
                        isShowTenant.value = true;
                        selectedTenant = tenant;
                      },
                      icon: Iconsax.more,
                    ),
                  ],
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
