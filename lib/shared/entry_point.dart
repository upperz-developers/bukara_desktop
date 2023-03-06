import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/views/start/splash_screen.dart';
import 'package:bukara/shared/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    _initPrefs();
    super.initState();
  }

  // fuction for initializing user app prefs
  void _initPrefs() async {
    AppPref.prefs = await SharedPreferences.getInstance();
    AppPref.prefs!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => AppBloc()),
      child: fluent.FluentApp(
        debugShowCheckedModeBanner: false,
        theme: Style.themeData(false, context),
        title: "Bukara",
        home: const SplashScreen(),
        routes: routes,
      ),
    );
  }
}
