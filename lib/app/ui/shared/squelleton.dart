import 'package:bukara/app/ui/shared/style.dart';
import 'package:flutter/material.dart';

class SimpleTextSquelleton extends StatelessWidget {
  const SimpleTextSquelleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 10,
      decoration: BoxDecoration(
        color: AppColors.DISABLE_COLOR,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
