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

Future<Response> editAppart(
    {Map<String, dynamic>? data,
    List<Map<String, dynamic>>? editedImage,
    String? appartId,
    Map<String, dynamic>? address,
    List<String>? imagePaths}) async {
  var endPoint = "${APIURL.ADDAPART}/$appartId";
  var response = await httpPutWithToken(
    endPoint: endPoint,
    data: data,
  );

  response = await httpPutWithToken(
    endPoint: APIURL.EDITADDRESSURL + appartId!,
    data: address,
  );

  if (editedImage!.isNotEmpty) {
    MultipartFile sendImage;
    for (Map<String, dynamic> imageToEdit in editedImage) {
      String fileName = imageToEdit['filePath'].split("/").last;
      sendImage = await MultipartFile.fromFile(
        imageToEdit['filePath'],
        filename: fileName,
      );
      FormData formData = FormData.fromMap(
        {
          "image": sendImage,
        },
      );
      response = await httpPutWithToken(
        endPoint: APIURL.EDITAPARTIMAGE + imageToEdit['imageId'],
        data: formData,
      );
    }
  }

  for (String path in imagePaths!) {
    List<MultipartFile> sendImages = [];
    String fileName = path.split("/").last;
    sendImages.add(
      await MultipartFile.fromFile(
        path,
        filename: fileName,
      ),
    );
    FormData formData = FormData.fromMap(
      {
        "image": sendImages,
      },
    );

    response = await httpPostWithToken(
      endPoint: APIURL.ADDAPARTIMAGE + appartId,
      data: formData,
    );
  }

  return response;
}

Future<Response> getSuite() async => httpGetWithToken(
      endPoint: APIURL.GETAPARTURL,
    );
