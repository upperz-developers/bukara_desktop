import 'package:bukara/app/ui/views/auth/auth.dart';
import 'package:bukara/app/ui/views/home/home.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Auth.routeName: (context) => const Auth(),
  Home.routeName: (context) => const Home(),
};
