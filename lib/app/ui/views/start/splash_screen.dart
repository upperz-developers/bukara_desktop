import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/ui/views/auth/auth.dart';
import 'package:bukara/app/ui/views/home/home.dart';
import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:flutter/material.dart';
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
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.DISABLE_COLOR,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            30.heightBox,
            const Text(
              "BUKARA Sarl",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            3.heightBox,
            const Text(
              "Build by Devinno in parternship with Upperz",
              style: TextStyle(
                fontSize: 10,
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
            3.heightBox,
            const Text(
              "V1.0.0",
              style: TextStyle(
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
