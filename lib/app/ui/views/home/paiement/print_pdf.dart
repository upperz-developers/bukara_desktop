import 'dart:io';

import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

void saveAndPrintPdf() async {
  final pdf = Document();

  final image = await imageFromAssetBundle('assets/icons/icon.png');
  double horizontalPadding = 50;

  final font = await PdfGoogleFonts.montserratRegular();
  final fontBold = await PdfGoogleFonts.montserratBold();

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return SizedBox();
        }
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: PdfColors.grey))),
          child: Text(
            'Recu de paiement',
            style: TextStyle(
              font: font,
              color: PdfColors.grey,
            ),
          ),
        );
      },
      footer: (Context context) {
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(
            top: 1.0 * PdfPageFormat.cm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Page ${context.pageNumber} sur ${context.pagesCount}',
                style: TextStyle(
                  font: font,
                  color: PdfColors.grey,
                ),
              ),
              Container(
                height: 1.5,
                width: 793.7007874,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: const BoxDecoration(
                  color: PdfColors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upperz",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "www.upper-z.com",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "baruka99.david@gmail.com",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "+243 (0) 973969675",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      margin: EdgeInsets.all(horizontalPadding),
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 55,
                width: 55,
                child: Image(image),
              ),
              Text(
                'Recu de paiement',
                textScaleFactor: 2,
                style: TextStyle(
                  font: fontBold,
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upperz",
                    style: TextStyle(
                      font: fontBold,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "52, avenu,himbi, de goma, goma, rdc",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Id Nat: 19-G4701-N9812J",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Num Impot: A2283021Q",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "CD/GOM/RCCM/21-A-01044",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CustomDate(date: DateTime.now()).getFullDate,
                  style: TextStyle(
                    font: font,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 15),
                Row(children: [
                  Text(
                    "Facture: UP3012220001",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
        Container(
          height: 1.5,
          width: 793.7007874,
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: const BoxDecoration(
            color: PdfColors.grey,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Locataire:",
              style: TextStyle(
                font: fontBold,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "David Baruka",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "+243 (0) 973959675 | baruka99.david@gmail.com",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Maison louee | 3 chambres & 2 salons | 52, avenu,himbi, de goma, goma, rdc",
                    style: TextStyle(
                      font: font,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            title1(title: "Libele", flex: 1, font: font),
            SizedBox(width: 1),
            title1(title: "Methode de paiement", flex: 1, font: font),
            SizedBox(width: 1),
            title1(title: "Numero de bordereau", flex: 1, font: font),
          ],
        ),
        SizedBox(height: 3),
        Container(
          decoration: const BoxDecoration(
            color: PdfColor(1, 1, 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              content1(
                  flex: 1,
                  title: "Paiement du loyer du moi de fevrier",
                  font: font),
              content1(
                  flex: 1,
                  title:
                      "This property is utilized so we can indicate a horizontal",
                  font: font),
              content1(
                  flex: 1,
                  title: "Numero de bordereau",
                  isEnd: true,
                  font: font),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: PdfColor(43 / 255, 81 / 255, 133 / 255),
              ),
              alignment: Alignment.center,
              child: Text(
                "#num",
                style: const TextStyle(
                  color: PdfColor(1, 1, 1),
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(width: 1),
            title1(title: "Libele", flex: 2, font: font),
            SizedBox(width: 1),
            title1(title: "Paye", flex: 1, font: font),
            SizedBox(width: 1),
            title1(title: "Rest", flex: 1, font: font),
          ],
        ),
        SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              child: Text(
                "1",
              ),
            ),
            SizedBox(width: 3),
            content1(
                flex: 2,
                title: "Paiement du loyer du moi de fevrier",
                font: font),
            content1(flex: 1, title: "450\$", font: font),
            content1(flex: 1, title: "200\$", isEnd: true, font: font),
          ],
        ),
        Container(
          height: 1,
          width: 793.7007874,
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          decoration: const BoxDecoration(
            color: PdfColors.grey,
          ),
        ),
      ],
    ),
  );

  final output = await getTemporaryDirectory();

  final file = File('${output.path}/testUpperz.pdf');

  await file.writeAsBytes(await pdf.save());
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

Widget title1({String? title, int? flex, required Font font}) {
  return Expanded(
    flex: flex!,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
        color: PdfColor(43 / 255, 81 / 255, 133 / 255),
      ),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: TextStyle(
          color: const PdfColor(1, 1, 1),
          fontSize: 10,
          font: font,
        ),
      ),
    ),
  );
}

Widget content1(
    {String? title, bool? isEnd, required int flex, required Font font}) {
  return Expanded(
    flex: flex,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(),
      alignment: Alignment.center,
      child: Text(
        title!,
        style:
            TextStyle(color: const PdfColor(0, 0, 0), fontSize: 12, font: font),
      ),
    ),
  );
}
