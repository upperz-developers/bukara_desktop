import 'package:flutter/material.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:iconsax/iconsax.dart';

class TenantInfo extends StatefulWidget {
  static String routeName = "/profile";
  const TenantInfo({Key? key}) : super(key: key);

  @override
  State<TenantInfo> createState() => _TenantInfo();
}

class _TenantInfo extends State<TenantInfo> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 350,
          width: 420,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: const Icon(
                        Icons.close,
                      ),
                      color: const Color.fromARGB(169, 32, 32, 32),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John doe",
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "physical person",
                        style: GoogleFonts.montserrat(
                          color: AppColors.BLACK_COLOR,
                        ),
                      ),
                      30.heightBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Iconsax.home),
                          15.widthBox,
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name of suite",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Goma, C de Goma, Q les volcan,av des avenues, num 10",
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.SECOND_TEXT_COLOR,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Divider(),
                      ),
                      Text(
                        "Apropos du locataire",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      25.heightBox,
                      module(Iconsax.document, "4 persons"),
                      module(Iconsax.home, "Maried"),
                      module2(Iconsax.tag, "Last Addres",
                          "Goma, C de Goma, Q les volcan,\nav des avenues, num 10"),
                      module(Iconsax.wallet_check, "Congolese"),
                      module2(Iconsax.tag, "2218096730973", "Passport"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget module(
    IconData? icon,
    String? message,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon),
          15.widthBox,
          Expanded(
            child: Text(
              "$message",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget module2(IconData? icon, String? title, String? message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          15.widthBox,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "$title",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "$message",
              style: GoogleFonts.montserrat(
                color: AppColors.SECOND_TEXT_COLOR,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
