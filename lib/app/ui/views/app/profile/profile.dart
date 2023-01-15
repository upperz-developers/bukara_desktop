import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/ui/views/app/home.dart';
import 'package:bukara/app/ui/views/app/profile/add_edit_enterprise_info.dart';
import 'package:bukara/app/ui/views/app/profile/profile_enterprise.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/shared/custom_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ValueNotifier<bool> isEdit = ValueNotifier(false);

  @override
  void initState() {
    context.read<AppBloc>().add(GETENTERPRISE());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustormScaffoldPage(
      onSuccess: () {
        if (isEdit.value) {
          Navigator.pushNamedAndRemoveUntil(
              context, Home.routeName, (route) => false);
        }
      },
      content: Padding(
        padding: EdgeInsets.only(
          left: horizontalSpace,
          right: horizontalSpace,
          bottom: 15,
          top: 15,
        ),
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return Column(
            children: [
              appTitle(state),
              ValueListenableBuilder(
                valueListenable: isEdit,
                builder: (context, bool edit, child) {
                  return Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10),
                      child: edit
                          ? AddEditEnterpriseInfo(
                              isEdit: isEdit,
                            )
                          : state is SUCCESS
                              ? ProfileEnterprise(
                                  isEdit: isEdit,
                                )
                              : const SizedBox.shrink(),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget appTitle(AppState state) {
    String? image;
    String? name = "";
    if (state is SUCCESS) {
      name = "";
    }
    return SizedBox(
      height: 190,
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
                      state is SUCCESS
                          ? Text(
                              name,
                              style: GoogleFonts.montserrat(
                                color: AppColors.SECOND_TEXT_COLOR,
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox.shrink(),
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
                        Iconsax.user,
                        size: 16,
                        color: mat.Colors.black54,
                      ),
                    ),
                    10.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${getUserPrefs().email}",
                          style: GoogleFonts.montserrat(
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
            child: Stack(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
                    ),
                    color: AppColors.WHITE_COLOR,
                    image: state is SUCCESS
                        ? image != null
                            ? DecorationImage(
                                image: CachedNetworkImageProvider(image),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage("assets/icons/bukara.jpg"),
                                fit: BoxFit.cover,
                              )
                        : const DecorationImage(
                            image: AssetImage("assets/icons/bukara.jpg"),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
