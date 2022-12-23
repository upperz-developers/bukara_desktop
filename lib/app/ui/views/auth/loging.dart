import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Loggin extends StatefulWidget {
  const Loggin({super.key});

  @override
  State<Loggin> createState() => _LogginState();
}

class _LogginState extends State<Loggin> {
  AuthController loginControler = AuthController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Connexion",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        30.heightBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nom d'utilisateur",
              style: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            FormText(
              hint: "Entrez votre nom d'utilisateur",
              optinal: false,
              controller: loginControler.userName,
            ),
            15.heightBox,
            Text(
              "Mot de passe",
              style: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            FormPassWordText(
              hint: "Entrez votre mot de passe",
              controller: loginControler.passWord,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
