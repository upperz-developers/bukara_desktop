import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  AuthController signupController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Creation du compte",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
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
              optinal: false,
              hint: "exemple@gmail.com",
              controller: signupController.userName,
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
              controller: signupController.passWord,
            ),
            15.heightBox,
            Text(
              "Confirmation",
              style: GoogleFonts.montserrat(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            FormPassWordText(
              hint: "Retaper votre mot de passe",
              controller: signupController.confirmPass,
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
