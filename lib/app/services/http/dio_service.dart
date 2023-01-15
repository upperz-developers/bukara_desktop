import 'dart:io';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/services/http/dio_helper.dart';
import 'package:dio/dio.dart';

httpGet({String? endPoint, Map<String, dynamic>? parameters}) async {
  return await Dio().get(
    "$endPoint",
    queryParameters: parameters,
    options: Options(
      headers: {
        "X-Requested-With": "XMLHttpRequest",
      },
    ),
  );
}

Future<Response> httpGetWithToken(
    {String? endPoint, Map<String, dynamic>? parameters}) async {
  Token token = getMobileToken();
  return await DioApi().dio.get(
        endPoint!,
        queryParameters: parameters,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token.token}',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );
}

/// ----------------------------------------------------------
/// Http "POST" request
/// ----------------------------------------------------------
httpPost({String? endPoint, Map<String, dynamic>? data}) async {
  return await DioApi().dio.post(
        endPoint!,
        options: Options(
          headers: {
            "X-Requested-With": "XMLHttpRequest",
            "Content-Type": "application/json",
          },
        ),
        data: data,
      );
}

Future<Response> httpPostWithToken({String? endPoint, var data}) async {
  Token token = getMobileToken();

  return await DioApi().dio.post(
        endPoint!,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token.token}',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );
}

httpPutWithToken({String? endPoint, var data}) async {
  Token token = getMobileToken();

  return await DioApi().dio.put(
        endPoint!,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token.token}',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );
}
