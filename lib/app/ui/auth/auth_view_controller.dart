import 'package:flutter/material.dart';

class AuthController {
  AuthController._internal();
  static final singleton = AuthController._internal();
  factory AuthController() => singleton;

  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
}
