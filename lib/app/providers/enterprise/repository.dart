import 'package:bukara/app/services/http/dio_service.dart';
import 'package:bukara/app/services/shared/api_url.dart';
import 'package:dio/dio.dart';

Future<Response> addEnterprise({Map<String, dynamic>? data}) async =>
    httpPostWithToken(
      endPoint: APIURL.ADDENTERPRISEURL,
      data: data,
    );

Future<Response> getEnterprise() async => httpGetWithToken(
      endPoint: APIURL.GETENTERPRISE,
    );
