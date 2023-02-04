import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/ui/views/auth/auth.dart';
import 'package:bukara/app/ui/views/app/home.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      Token token = Token();
      token = getMobileToken();
      if (token.token!.isNotEmpty) {
        Navigator.pushReplacementNamed(context, Home.routeName);
        return;
      }
      Navigator.pushReplacementNamed(context, Auth.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: AppColors.DISABLE_COLOR,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/icons/bukara.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            30.heightBox,
            Text(
              "BUKARA Sarl",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            3.heightBox,
            Text(
              "Build by Upperz in parternship with Devinno",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
            3.heightBox,
            Text(
              "V1.0.0",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
