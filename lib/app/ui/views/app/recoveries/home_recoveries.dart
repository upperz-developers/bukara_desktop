import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/recovery/model.dart';
import 'package:bukara/app/ui/shared/utils/no_data.dart';
import 'package:bukara/app/ui/squeletton/recovery_squeletton.dart';
import 'package:bukara/app/ui/views/app/recoveries/show_recovery.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/shared/custom_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class RecoveryHome extends StatefulWidget {
  const RecoveryHome({super.key});

  @override
  State<RecoveryHome> createState() => _RecoveryHomeState();
}

class _RecoveryHomeState extends State<RecoveryHome> {
  AppBloc bloc = AppBloc();
  @override
  void initState() {
    bloc.add(GETRECOVERYINFO());
    super.initState();
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
            child: appBar(context, title: "Recouvrement"),
          ),
          Expanded(
            child: BlocBuilder<AppBloc, AppState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is LOADING) {
                  return const RecoverySqueletton();
                } else if (state is SUCCESS) {
                  List<ContratData> contratData = state.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoTabBar(),
                      ShowRecovery(
                        contratData: contratData,
                        bloc: bloc,
                      ),
                    ],
                  );
                } else if (state is ERROR) {
                  return NoData(
                    message: state.dueTo!,
                    onTap: () {
                      bloc.add(GETRECOVERYINFO());
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

  Widget infoTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalSpace),
      decoration: const BoxDecoration(
        color: AppColors.DISABLE_COLOR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
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
                          ),
                        ),
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
