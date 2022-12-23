import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/hover_animation.dart';
import 'package:bukara/app/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class SuiteDetail extends StatefulWidget {
  static String routeName = "/detail_suite";
  const SuiteDetail({super.key});

  @override
  State<SuiteDetail> createState() => _SuiteDetailState();
}

class _SuiteDetailState extends State<SuiteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: 30, horizontal: horizontalSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail de l'appartement",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    30.heightBox,
                    showImage(),
                    45.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Appartement name - 150\$ par mois",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                10.heightBox,
                                Text(
                                  "#numero 25 (3 chambres - 1 salon)",
                                  style: GoogleFonts.montserrat(),
                                ),
                                20.heightBox,
                                Text(
                                  "Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.SECOND_TEXT_COLOR,
                                    fontSize: 12,
                                    height: 1.5,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(),
                                ),
                                caracteristic(),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 20),
                                  child: Divider(),
                                ),
                                Text(
                                  "Autres informations",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                30.heightBox,
                                otherInfo(),
                              ],
                            ),
                          ),
                          45.widthBox,
                          Container(
                            margin: const EdgeInsets.only(top: 70),
                            width: 400,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: AppColors.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.SECOND_TEXT_COLOR,
                                    height: 1.5,
                                  ),
                                ),
                                15.heightBox,
                                Text(
                                  "20 jours restants",
                                  style: GoogleFonts.montserrat(
                                    height: 1.5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "20 dec - 30 janvier",
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.SECOND_TEXT_COLOR,
                                    height: 1.5,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(),
                                ),
                                OnHoverEffect(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: const BoxDecoration(
                                            color: AppColors.DISABLE_COLOR,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Iconsax.user,
                                          ),
                                        ),
                                        15.widthBox,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "John doe",
                                                style: GoogleFonts.montserrat(
                                                  height: 1.5,
                                                ),
                                              ),
                                              Text(
                                                "Personne physique",
                                                style: GoogleFonts.montserrat(
                                                  color: AppColors
                                                      .SECOND_TEXT_COLOR,
                                                  height: 1.5,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        15.widthBox,
                                        const Icon(
                                          Iconsax.arrow_right,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(),
                                ),
                                TableCalendar(
                                  rowHeight: 53,
                                  headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      headerPadding: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      titleCentered: true,
                                      leftChevronIcon: Icon(
                                        Iconsax.arrow_left_2,
                                      ),
                                      rightChevronIcon: Icon(
                                        Iconsax.arrow_right_3,
                                      ),
                                      titleTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  calendarStyle: const CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        shape: BoxShape.circle),
                                    todayDecoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        shape: BoxShape.circle),
                                  ),
                                  availableGestures: AvailableGestures.all,
                                  focusedDay: DateTime.now(),
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2050, 3, 14),
                                  onDaySelected: (day1, day2) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget caracteristic() {
    return Column(
      children: [
        caracteristicModel(
          title: "Appartement no 23",
          icon: Iconsax.box,
        ),
        caracteristicModel(
          title:
              "5,avenue du lac, quartier katindo 1, commune de goma, ville de goma, Goma, congo/kinshasa",
          icon: Iconsax.map_1,
        ),
        caracteristicModel(
          title: "4 chambres",
          icon: Iconsax.box,
        ),
        caracteristicModel(
          title: "2 Salon",
          icon: Iconsax.home,
        ),
        caracteristicModel(
          title: "1 toillette interne",
          icon: Iconsax.safe_home,
        ),
        caracteristicModel(
          title: "0 toillette externe",
          icon: Iconsax.activity,
          exist: false,
        ),
      ],
    );
  }

  Widget otherInfo() {
    return Column(
      children: [
        caracteristicModel(
          title: "Connxion internet",
          icon: Iconsax.wifi,
        ),
        caracteristicModel(
          title: "Cash power",
          icon: Iconsax.flash,
        ),
        caracteristicModel(
          title: "Snel",
          icon: Iconsax.flash,
          exist: false,
        ),
        caracteristicModel(
          title: "Regideso",
          icon: Iconsax.omega_circle,
        ),
        caracteristicModel(
          title: "toillette interne",
          icon: Iconsax.safe_home,
        ),
        caracteristicModel(
          title: "toillette externe",
          icon: Iconsax.activity,
          exist: false,
        ),
        caracteristicModel(
          title: "Piscine",
          icon: Iconsax.activity,
          exist: false,
        ),
        caracteristicModel(
          title: "Parking",
          icon: Iconsax.activity,
          exist: false,
        ),
      ],
    );
  }

  Widget caracteristicModel({IconData? icon, String? title, bool? exist}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child: Text(
              title!,
              style: GoogleFonts.montserrat(
                height: 1.5,
                decoration: exist == false ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    return Row(
      children: [
        Expanded(
          child: OnHoverEffect(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 448,
                width: 600,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.SECOND_CARD_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/suite.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        8.widthBox,
        Column(
          children: [
            Row(
              children: [
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 220,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        image: DecorationImage(
                          image: AssetImage("assets/images/suite.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 220,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/suite.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 220,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        image: DecorationImage(
                          image: AssetImage("assets/images/suite.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                8.widthBox,
                OnHoverEffect(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 220,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: AppColors.SECOND_CARD_COLOR,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/suite.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
