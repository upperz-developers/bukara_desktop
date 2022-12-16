import 'package:bukara/app/ui/auth/auth_view_controller.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Loggin extends StatefulWidget {
  final AuthController? loginControler;
  const Loggin({super.key, this.loginControler});

  @override
  State<Loggin> createState() => _LogginState();
}

class _LogginState extends State<Loggin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Connexion",
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
            FormText(
              hint: "Entrez votre nom d'utilisateur",
              controller: widget.loginControler!.userName,
            ),
            15.heightBox,
            const Text(
              "Mot de passe",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            10.heightBox,
            FormPassWordText(
              hint: "Entrez votre mot de passe",
              controller: widget.loginControler!.passWord,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.loginControler!.userName = TextEditingController();
    widget.loginControler!.passWord = TextEditingController();
    super.dispose();
  }
}
