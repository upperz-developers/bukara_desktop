import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/services/http/dio_service.dart';
import 'package:bukara/app/services/shared/api_url.dart';
import 'package:dio/dio.dart';

List<Suite> suites = [];

Future<Response> addAppart(
    {Map<String, dynamic>? data, List<String>? imagePaths}) async {
  var response = await httpPostWithToken(
    endPoint: APIURL.ADDAPART,
    data: data,
  );

  List<MultipartFile> sendImages = [];
  for (String path in imagePaths!) {
    String fileName = path.split("/").last;
    sendImages.add(
      await MultipartFile.fromFile(
        path,
        filename: fileName,
      ),
    );
  }

  FormData formData = FormData.fromMap(
    {
      "image": sendImages,
    },
  );
  String suitId = response.data['data']['appartement']['id'];
  response = await httpPostWithToken(
    endPoint: APIURL.ADDAPARTIMAGE + suitId,
    data: formData,
  );
  return response;
}

Future<Response> getSuite() async => httpGetWithToken(
      endPoint: APIURL.GETAPARTURL,
    );
