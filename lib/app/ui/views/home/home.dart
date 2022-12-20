import 'package:bukara/app/ui/views/home/profile/profile.dart';
import 'package:bukara/app/ui/views/home/suite/suite_home.dart';
import 'package:bukara/app/ui/views/start/shared/app_architecture.dart';
import 'package:bukara/app/ui/views/start/shared/style.dart';
import 'package:bukara/app/ui/views/start/shared/widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:iconsax/iconsax.dart';

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
            icon: selectedNav == index ? kIcons25[index] : kIcons[index],
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
            icon: Iconsax.user,
            index: 5,
            selectedIndex: selectedNav,
            onTap: () {
              setState(() {
                selectedNav = 5;
              });
            },
          ),
        ],
        content: NavigationBody(
          index: selectedNav,
          children: [
            const SuiteHome(),
            Container(),
            Container(),
            Container(),
            Container(),
            const Profile(),
          ],
        ),
      ),
    );
  }
}
