import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

List<IconData> kIcons = [
  fluent.FluentIcons.user_window,
  fluent.FluentIcons.shopping_cart,
  fluent.FluentIcons.task_manager,
  fluent.FluentIcons.custom_activity,
  fluent.FluentIcons.money,
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
          size: 20,
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
  const FormText({super.key, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.BORDER_COLOR,
        ),
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 12,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(
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
      width: 300,
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
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    controller: widget.controller,
                    obscureText: isObscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
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
                    isObscureText ? UniconsLine.eye : UniconsLine.eye_slash,
                    size: 20,
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
  const CustomButton(
      {super.key,
      required this.title,
      this.textColor,
      this.backgroundColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 300,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
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
    style: const TextStyle(
      fontFamily: "Montserrat",
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
