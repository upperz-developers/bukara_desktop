import 'dart:io';

import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

void saveAndPrintPdf(
    {required Enterprise enterprise,
    required PayementHistoric payement}) async {
  final pdf = Document();

  final image = await imageFromAssetBundle('assets/icons/bukara.jpg');
  double horizontalPadding = 50;
  DateTime paiedAt = DateTime.parse(payement.createdAt!);
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
                    "${enterprise.designation}",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "www.bukara.sarl",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "bukara@gmail.sarl",
                    style: TextStyle(
                      font: font,
                    ),
                  ),
                  Text(
                    "+243 (0) 9700000000",
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
                  if (enterprise.designation != null)
                    Text(
                      "${enterprise.designation}",
                      style: TextStyle(
                        font: fontBold,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    "${enterprise.addresses![0].number}, ${enterprise.addresses![0].street}, ${enterprise.addresses![0].quarter}, commune, ${enterprise.addresses![0].town}, ${enterprise.addresses![0].country}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${enterprise.rccm}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                  if (enterprise.idnat != null)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "${enterprise.idnat}",
                          style: TextStyle(
                            font: font,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  if (enterprise.impot != null)
                    Column(children: [
                      SizedBox(height: 10),
                      Text(
                        "${enterprise.impot}",
                        style: TextStyle(
                          font: font,
                          fontSize: 10,
                        ),
                      ),
                    ]),
                ],
              ),
            ),
            SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CustomDate(date: paiedAt).getFullDate,
                  style: TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 15),
                Row(children: [
                  Text(
                    "Facture: ${enterprise.designation?.substring(0, 3)}${paiedAt.day}${paiedAt.month}${paiedAt.year}${paiedAt.second}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
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
                    "${payement.contratData!.rentalContrat!.landlord!.name} ${payement.contratData!.rentalContrat!.landlord!.lastname}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${payement.contratData!.rentalContrat!.landlord!.email}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${payement.contratData!.rentalContrat!.appartement!.designation} | numero ${payement.contratData!.rentalContrat!.appartement!.number},${payement.contratData!.rentalContrat!.appartement!.features!.bedroom} chambres - ${payement.contratData!.rentalContrat!.appartement!.features!.livingroom} salon| ${payement.contratData!.rentalContrat!.appartement!.address}",
                    style: TextStyle(
                      font: font,
                      fontSize: 10,
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
                  title: "${payement.contratData!.labelStr}",
                  font: font),
              content1(flex: 1, title: "${payement.type}", font: font),
              content1(
                  flex: 1,
                  title: payement.type == "cash"
                      ? ""
                      : "${payement.transactionId}",
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                title: "${payement.contratData!.labelStr}",
                font: font),
            content1(flex: 1, title: "${payement.amount}\$", font: font),
            content1(flex: 1, title: "-\$", isEnd: true, font: font),
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: const BoxDecoration(),
      alignment: Alignment.center,
      child: Text(
        title!,
        style:
            TextStyle(color: const PdfColor(0, 0, 0), fontSize: 10, font: font),
      ),
    ),
  );
}
