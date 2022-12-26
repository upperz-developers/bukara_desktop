import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/app/ui/views/home/tenant/add_tenant.dart';
import 'package:bukara/shared/custom_scaffold.dart';
import 'package:flutter/material.dart';
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
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            child: Column(
                              children: [
                                tabDetail(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        30,
                                        (index) => tenantDetail(
                                          index: index,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        30.widthBox,
                        Container(
                          width: isShowDetail ? 300 : 0,
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
                }),
          ),
        ],
      ),
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
              ),
              15.widthBox,
              modelAction(
                icon: Iconsax.shop_remove,
              ),
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
                    "John doe",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "physical person",
                    style: GoogleFonts.montserrat(
                      color: AppColors.BLACK_COLOR,
                    ),
                  ),
                  30.heightBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Iconsax.home),
                      15.widthBox,
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name of suite",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              5.heightBox,
                              Text(
                                "Goma, C de Goma, Q les volcan,av des avenues, num 10",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: AppColors.SECOND_TEXT_COLOR,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(),
                  ),
                  Text(
                    "Apropos du locataire",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  25.heightBox,
                  module(Iconsax.document, "4 persons"),
                  module(Iconsax.home, "Maried"),
                  module2(Iconsax.tag, "Last Addres",
                      "Goma, C de Goma, Q les volcan,\nav des avenues, num 10"),
                  module(Iconsax.wallet_check, "Congolese"),
                  module2(Iconsax.tag, "2218096730973", "Passport"),
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
            Expanded(
              flex: 1,
              child: tabDetailModel(title: "#numero"),
            ),
            space.widthBox,
            Expanded(
              flex: 2,
              child: tabDetailModel(title: "Responsable"),
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
                showDialog(
                  context: context,
                  builder: (context) => const AddTenants(),
                  barrierDismissible: false,
                );
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
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: "Tapez un mot cle",
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
  }) {
    double space = 10;
    return Container(
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
          Expanded(
            flex: 1,
            child: suiteDetailModel(
              title: "00${index + 1}",
            ),
          ),
          space.widthBox,
          Expanded(
            flex: 2,
            child: suiteDetailModel(title: "Responsable name"),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: suiteDetailModel(title: "Celibataire"),
          ),
          space.widthBox,
          Expanded(
            flex: 3,
            child: suiteDetailModel(
                title: "52, avenu, quartier, commune, ville, province, pays"),
          ),
          space.widthBox,
          Expanded(
            flex: 1,
            child: Wrap(
              spacing: 20,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                modelAction(
                  icon: Iconsax.edit,
                ),
                modelAction(
                  icon: Iconsax.shop_remove,
                ),
                modelAction(
                  onTap: () {
                    isShowTenant.value = true;
                  },
                  icon: Iconsax.more,
                ),
              ],
            ),
          ),
        ],
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
