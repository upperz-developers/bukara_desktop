import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/suite/provider.dart';
import 'package:bukara/app/ui/shared/utils/no_data.dart';
import 'package:bukara/app/ui/squeletton/suite_squeletton.dart';
import 'package:bukara/app/ui/views/app/suite/add_suite.dart';
import 'package:bukara/app/ui/views/app/suite/show_suite.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/shared/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class SuiteHome extends StatefulWidget {
  const SuiteHome({super.key});

  @override
  State<SuiteHome> createState() => _SuiteHomeState();
}

class _SuiteHomeState extends State<SuiteHome>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  AppBloc bloc = AppBloc();
  TextEditingController? search;
  @override
  void initState() {
    isSuiteEdit = false;
    suiteToEdit = null;
    controller = TabController(length: 3, vsync: this);
    search = TextEditingController();
    suites = [];
    bloc.add(
      GETSUITE(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ValueNotifier<bool> isShowingData = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return CustormScaffoldPage(
      onSuccess: () {
        setState(() {
          isShowingData.value = true;
          bloc.add(GETSUITE());
        });
      },
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
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
            Expanded(
              child: BlocBuilder<AppBloc, AppState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is LOADING) {
                      return const SuiteSqueletton();
                    } else if (state is SUCCESS) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoTabBar(),
                          ValueListenableBuilder(
                            valueListenable: isShowingData,
                            builder: (context, bool isData, child) {
                              return isData
                                  ? ShowSuite(
                                      isShowingData: isShowingData,
                                      search: search,
                                    )
                                  : AddSuite(
                                      showSuites: isShowingData,
                                    );
                            },
                          ),
                        ],
                      );
                    } else if (state is ERROR) {
                      return NoData(
                        dueTo: state.dueTo!.errors!,
                        onTap: () {
                          bloc.add(
                            GETSUITE(),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTabBar() {
    return Container(
      padding: const EdgeInsets.only(
        left: 130,
        right: 130,
        top: 10,
        bottom: 10,
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
                isShowingData.value = false;
                isSuiteEdit = false;
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
                        hintText: "Tapez un mot clé",
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
}
