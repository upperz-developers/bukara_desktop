import 'package:bukara/app/services/http/dio_service.dart';
import 'package:bukara/app/services/shared/api_url.dart';
import 'package:dio/dio.dart';

Future<Response> addTenant(
        {Map<String, dynamic>? data, List<String>? imagePaths}) async =>
    await httpPostWithToken(
      endPoint: APIURL.ADDTENANT,
      data: data,
    );

Future<Response> getTenant() async => await httpGetWithToken(
      endPoint: APIURL.GETTENANT,
    );

Future<Response> rentalContrat({Map<String, dynamic>? data}) async =>
    await httpPostWithToken(
      endPoint: APIURL.CONTRATTENANT,
      data: data,
    );
