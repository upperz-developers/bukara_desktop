import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';
import 'package:bukara/app/ui/views/auth/loging.dart';
import 'package:bukara/app/ui/views/auth/signup.dart';
import 'package:bukara/app/ui/views/home/home.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:bukara/shared/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/style.dart';

class Auth extends StatefulWidget {
  static String routeName = "/auth";
  const Auth({super.key});
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  ValueNotifier<bool> isLogin = ValueNotifier(true);
  AuthController authController = AuthController();

  void _login({required BuildContext context}) {
    context.read<AppBloc>().add(
          LOGINEVENT(
            username: authController.userName.text.trim(),
            password: authController.passWord.text.trim(),
          ),
        );
  }

  void _signup({required BuildContext context}) {
    context.read<AppBloc>().add(
          SIGNUP(
            username: authController.userName.text.trim(),
            password: authController.passWord.text.trim(),
            confirmPass: authController.confirmPass.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustormScaffold(
      onSuccess: () {
        if (isLogin.value) {
          authController.confirmPass.clear();
          authController.passWord.clear();
          authController.userName.clear();
          Navigator.pushReplacementNamed(context, Home.routeName);
          return;
        }
        isLogin.value = true;
      },
      body: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width / 2 + 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                  image: AssetImage('assets/images/suite.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: isLogin,
              builder: (context, bool isLoginAction, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoginAction ? const Loggin() : const Signup(),
                    30.heightBox,
                    callToAction(isLoginAction),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget callToAction(bool isLoginAction) {
    return Column(
      children: [
        CustomButton(
          onTap: () {
            if (isLoginAction) {
              _login(
                context: context,
              );
              return;
            }

            _signup(
              context: context,
            );
          },
          title: isLoginAction ? "Connexion" : "Creer un compte",
          textColor: AppColors.WHITE_COLOR,
          backgroundColor: AppColors.BLACK_COLOR,
        ),
        15.heightBox,
        SizedBox(
          width: 250,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: AppColors.BORDER_COLOR,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              10.widthBox,
              Text(
                "ou",
                style: GoogleFonts.montserrat(),
              ),
              10.widthBox,
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: AppColors.BORDER_COLOR,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        15.heightBox,
        CustomButton(
          onTap: () {
            isLogin.value = !isLogin.value;
          },
          title: isLoginAction ? "Creer un compte" : "Connexion",
          textColor: AppColors.BLACK_COLOR,
          backgroundColor: AppColors.DISABLE_COLOR,
        ),
      ],
    );
  }
}
