import 'package:bukara/app/services/http/dio_service.dart';
import 'package:bukara/app/services/shared/api_url.dart';
import 'package:dio/dio.dart';

Future<Response> loggin({String? username, String? password}) async {
  return await httpPost(endPoint: APIURL.LOGIN, data: {
    "email": username,
    "password": password,
  });
}

Future<Response> signup(
        {String? username, String? password, String? confirmPass}) async =>
    await httpPost(
      endPoint: APIURL.SIGNUP,
      data: {
        "email": username,
        "password": password,
        "password_confirmation": confirmPass,
      },
    );
