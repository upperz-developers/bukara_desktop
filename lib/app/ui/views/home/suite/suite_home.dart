import 'package:bukara/app/ui/views/home/suite/add_suite.dart';
import 'package:bukara/app/ui/views/home/suite/show_suite.dart';
import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:bukara/app/ui/views/start/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/views/start/shared/widget.dart';
import 'package:bukara/shared/custom_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> infoBar = ["Tout", "Occupe", "Non occupe"];

class SuiteHome extends StatefulWidget {
  const SuiteHome({super.key});

  @override
  State<SuiteHome> createState() => _SuiteHomeState();
}

class _SuiteHomeState extends State<SuiteHome>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  ValueNotifier<bool> isShowingData = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return CustormScaffoldPage(
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
            child: appBar(context, title: "Appartements"),
          ),
          infoTabBar(),
          ValueListenableBuilder(
              valueListenable: isShowingData,
              builder: (context, bool isData, child) {
                return isData
                    ? const ShowSuite()
                    : AddSuite(
                        showSuites: isShowingData,
                      );
              })
        ],
      ),
    );
  }

  Widget infoTabBar() {
    return Container(
      padding: const EdgeInsets.only(
        left: 130,
        right: 130,
      ),
      decoration: const BoxDecoration(
        color: AppColors.DISABLE_COLOR,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: List.generate(
                infoBar.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.DISABLE_COLOR,
                      ),
                      child: Text(
                        infoBar[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: AppColors.SECOND_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              OnHoverEffect(
                child: InkWell(
                  onTap: () {
                    isShowingData.value = false;
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
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
        ],
      ),
    );
  }
}
