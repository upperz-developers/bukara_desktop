import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

double horizontalSpace = 130;

List<IconData> kIcons = [
  Iconsax.home,
  Iconsax.user_add,
  Iconsax.folder,
  Iconsax.receipt,
];

List<IconData> kIcons25 = [
  Iconsax.home_25,
  Iconsax.user_add,
  Iconsax.folder_25,
  Iconsax.receipt_25
];

Widget modelMenuApp(
  fluent.BuildContext context, {
  String? title,
  IconData? icon,
  int? index,
  int? selectedIndex,
  Function()? onTap,
}) {
  return OnHoverEffect(
    child: fluent.Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const fluent.EdgeInsets.only(
            top: 5,
            bottom: 5,
            right: 5,
            left: 5,
          ),
          alignment: Alignment.center,
          padding: fluent.EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 10,
            left: index == selectedIndex ? 7 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: index == selectedIndex
                ? AppColors.DISABLE_COLOR
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (index == selectedIndex)
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.BLACK_COLOR,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              Icon(
                icon,
                size: 16,
                color: index == selectedIndex ? Colors.black : Colors.black54,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget modelMenuFootApp(
  fluent.BuildContext context, {
  String? title,
  IconData? icon,
  int? index,
  int? selectedIndex,
  Function()? onTap,
}) {
  return OnHoverEffect(
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        // padding: const fluent.EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == selectedIndex
              ? AppColors.BLACK_COLOR
              : AppColors.DISABLE_COLOR,
        ),
        child: Icon(
          icon,
          size: 16,
          color:
              index == selectedIndex ? AppColors.WHITE_COLOR : Colors.black54,
        ),
      ),
    ),
  );
}

class FormText extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool? optinal;
  final bool? submitted;
  final double? width;
  const FormText(
      {super.key,
      this.hint,
      this.controller,
      this.optinal,
      this.submitted,
      this.width});

  @override
  Widget build(BuildContext context) {
    bool validation =
        optinal != false && controller!.text.isEmpty && submitted == true;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: width ?? 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: validation ? 1.5 : 1,
          color: validation ? AppColors.RED_COLOR : AppColors.BORDER_COLOR,
        ),
      ),
      child: TextField(
        style: GoogleFonts.montserrat(
          fontSize: 12,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class FormPassWordText extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  const FormPassWordText({super.key, this.hint, this.controller});

  @override
  State<FormPassWordText> createState() => _FormPassWordTextState();
}

class _FormPassWordTextState extends State<FormPassWordText> {
  ValueNotifier<bool> isObscure = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.BORDER_COLOR,
        ),
      ),
      child: ValueListenableBuilder(
          valueListenable: isObscure,
          builder: (context, bool isObscureText, child) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                    controller: widget.controller,
                    obscureText: isObscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: widget.hint,
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                10.widthBox,
                InkWell(
                  onTap: () {
                    isObscure.value = !isObscure.value;
                  },
                  child: Icon(
                    isObscureText ? Iconsax.eye : Iconsax.eye_slash,
                    size: 16,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final Color? backgroundColor;
  final Function()? onTap;
  final double? width;
  final AppState? state;
  const CustomButton(
      {super.key,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.onTap,
      this.width,
      this.state});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: width ?? 250,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state is LOADING
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: AppColors.WHITE_COLOR,
                    ),
                  )
                : Text("$title",
                    style: GoogleFonts.montserrat(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    )),
          ],
        ),
      ),
    );
  }
}

Widget appBar(
  fluent.BuildContext context, {
  String? title,
}) {
  return Text(
    title!,
    style: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

alertMessage(
  BuildContext context, {
  String? head,
  String? body,
  String? action,
  String? action1,
  Function()? onTap,
  Function()? onTap1,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(.3),
    barrierDismissible: true,
    builder: (context) => SimpleDialog(
      backgroundColor: fluent.FluentTheme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      head!,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      body!,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: AppColors.SECOND_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: fluent.FluentTheme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.DISABLE_COLOR,
                        ),
                        child: Text(
                          action!,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    15.widthBox,
                    InkWell(
                      onTap: onTap1,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.BLACK_COLOR,
                        ),
                        child: Text(
                          action1!,
                          style: GoogleFonts.montserrat(
                            color: AppColors.WHITE_COLOR,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

alertInfo(
  BuildContext context, {
  String? head,
  String? body,
  String? action,
  Function()? onTap,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(.3),
    barrierDismissible: true,
    builder: (context) => SimpleDialog(
      backgroundColor: fluent.FluentTheme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      head!,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      body!,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: AppColors.SECOND_TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: fluent.FluentTheme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.DISABLE_COLOR,
                        ),
                        child: Text(
                          action!,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget line({double? padding}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 1,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 215, 214, 214),
          ),
        ),
      ),
    ],
  );
}

Widget custormButtonLogout(
  BuildContext context, {
  Color? color,
  String? title,
  Color? colorText,
  Function()? onTap,
  AppState? state,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state is LOADING
              ? const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: AppColors.WHITE_COLOR,
                  ),
                )
              : Text("$title",
                  style: GoogleFonts.montserrat(
                    color: colorText,
                    fontWeight: FontWeight.bold,
                  )),
        ],
      ),
    ),
  );
}
