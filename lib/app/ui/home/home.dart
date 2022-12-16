import 'package:bukara/app/ui/home/profile/profile.dart';
import 'package:bukara/app/ui/shared/app_architecture.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;

class Home extends StatefulWidget {
  static String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedNav = 0;

  @override
  Widget build(BuildContext context) {
    return mat.Scaffold(
      body: ArchitectureApp(
        menuBackgroundColor: Colors.white,
        header: Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 30),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: AppColors.DISABLE_COLOR,
              border: Border.all(
                width: 3,
                color: AppColors.DISABLE_COLOR,
              ),
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage("assets/icons/bukara.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        items: List.generate(
          kIcons.length,
          (index) => modelMenuApp(
            context,
            icon: kIcons[index],
            index: index,
            selectedIndex: selectedNav,
            onTap: () {
              setState(() {
                selectedNav = index;
              });
            },
          ),
        ),
        footer: [
          modelMenuFootApp(
            context,
            icon: mat.Icons.person,
            index: 5,
            selectedIndex: selectedNav,
            onTap: () {
              setState(() {
                selectedNav = 5;
              });
            },
          ),
        ],
        content: Padding(
          padding: const EdgeInsets.only(
            left: 75,
            right: 75,
            bottom: 15,
            top: 15,
          ),
          child: NavigationBody(
            index: selectedNav,
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              const Profile(),
            ],
          ),
        ),
      ),
    );
  }
}
