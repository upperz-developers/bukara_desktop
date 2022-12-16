import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Creation du compte",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        30.heightBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nom d'utilisateur",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            const FormText(
              hint: "Entrez votre nom d'utilisateur",
            ),
            15.heightBox,
            const Text(
              "Mot de passe",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            const FormPassWordText(
              hint: "Entrez votre mot de passe",
            ),
            15.heightBox,
            const Text(
              "Confirmation",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            const FormPassWordText(
              hint: "Entre de nouveau votre mot de passe",
            ),
          ],
        ),
      ],
    );
  }
}
