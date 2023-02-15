import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/ui/shared/utils/custorm_date.dart';
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
      pageFormat: PdfPageFormat.a5,
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
            'Reçu de paiement',
            style: TextStyle(
              font: font,
              fontSize: 12,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(children: [
                  Text(
                    "Merci de nous avoir fait confiance",
                    style: TextStyle(
                      font: font,
                      fontSize: 06,
                    ),
                  ),
                  Text(
                    "${enterprise.banks?[0].accountName} | ${enterprise.banks?[0].bank} | ${enterprise.banks?[0].accountNumber}",
                    style: TextStyle(
                      font: font,
                      fontSize: 06,
                    ),
                  ),
                ]),
              ),
              Text(
                'Page ${context.pageNumber} sur ${context.pagesCount}',
                style: TextStyle(
                  font: font,
                  color: PdfColors.grey,
                  fontSize: 06,
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
                      fontSize: 06,
                    ),
                  ),
                  Text(
                    "${enterprise.site}",
                    style: TextStyle(
                      font: font,
                      fontSize: 06,
                    ),
                  ),
                  Text(
                    "${enterprise.email}",
                    style: TextStyle(
                      font: font,
                      fontSize: 06,
                    ),
                  ),
                  Text(
                    "${enterprise.phones}",
                    style: TextStyle(
                      font: font,
                      fontSize: 06,
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
                height: 30,
                width: 30,
                child: Image(image),
              ),
              Text(
                'Reçu de paiement',
                style: TextStyle(
                  fontSize: 14,
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
                        fontSize: 08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    "${enterprise.addresses![0].number}, ${enterprise.addresses![0].street}, ${enterprise.addresses![0].quarter}, commune, ${enterprise.addresses![0].town}, ${enterprise.addresses![0].country}",
                    style: TextStyle(
                      font: font,
                      fontSize: 6,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${enterprise.rccm}",
                    style: TextStyle(
                      font: font,
                      fontSize: 6,
                    ),
                  ),
                  if (enterprise.idnat != null)
                    Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          "${enterprise.idnat}",
                          style: TextStyle(
                            font: font,
                            fontSize: 6,
                          ),
                        ),
                      ],
                    ),
                  if (enterprise.impot != null)
                    Column(children: [
                      SizedBox(height: 8),
                      Text(
                        "${enterprise.impot}",
                        style: TextStyle(
                          font: font,
                          fontSize: 6,
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
                    fontSize: 6,
                  ),
                ),
                SizedBox(height: 10),
                Row(children: [
                  Text(
                    "Facture: ${enterprise.designation?.substring(0, 3)}${paiedAt.day}${paiedAt.month}${paiedAt.year}${paiedAt.second}",
                    style: TextStyle(
                      font: font,
                      fontSize: 8,
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
          margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                fontSize: 8,
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
                      fontSize: 6,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${payement.contratData!.rentalContrat!.landlord!.email}",
                    style: TextStyle(
                      font: font,
                      fontSize: 6,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${payement.contratData!.rentalContrat!.appartement!.designation} |${payement.contratData!.rentalContrat!.appartement!.features!.bedroom} chambres - ${payement.contratData!.rentalContrat!.appartement!.features!.livingroom} salon",
                    style: TextStyle(
                      font: font,
                      fontSize: 6,
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
            title1(title: "Méthode de paiement", flex: 1, font: font),
            SizedBox(width: 1),
            title1(title: "Numéro de bordereau", flex: 1, font: font),
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
        SizedBox(height: 10),
        Row(
          children: [
            title1(title: "Libellé", flex: 2, font: font),
            SizedBox(width: 1),
            title1(title: "Montant payé", flex: 1, font: font),
            SizedBox(width: 1),
            title1(title: "Reste", flex: 1, font: font),
          ],
        ),
        SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content1(
              flex: 2,
              title: "Paiement recouvrement du ${CustomDate(
                date: DateTime.parse(payement.contratData!.createdAt!),
              ).getFullDate} au ${CustomDate(
                date: DateTime.parse(payement.contratData!.dateRecovery!),
              ).getFullDate}",
              font: font,
            ),
            content1(flex: 1, title: "${payement.amount}\$", font: font),
            SizedBox(width: 3),
            content1(
              flex: 1,
              title:
                  payement.leftToPay != null ? "${payement.leftToPay}\$" : "",
              font: font,
            ),
          ],
        ),
        Container(
          height: 1,
          width: 793.7007874,
          margin: const EdgeInsets.only(top: 8, bottom: 10),
          decoration: const BoxDecoration(
            color: PdfColors.grey,
          ),
        ),
      ],
    ),
  );

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}

Widget title1({String? title, int? flex, required Font font}) {
  return Expanded(
    flex: flex!,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      decoration: const BoxDecoration(
        color: PdfColor(43 / 255, 81 / 255, 133 / 255),
      ),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: TextStyle(
          color: const PdfColor(1, 1, 1),
          fontSize: 6,
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
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      decoration: const BoxDecoration(),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: TextStyle(
          color: const PdfColor(0, 0, 0),
          fontSize: 6,
          height: 1.5,
          font: font,
        ),
      ),
    ),
  );
}
