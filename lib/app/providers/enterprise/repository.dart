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

Future<Response> editEnterprise(
    {Map<String, dynamic>? enterprise,
    Map<String, dynamic>? address,
    Map<String, dynamic>? bank}) async {
  print(enterprise!['id']);
  var response = await httpPutWithToken(
    endPoint: APIURL.UPDATEENTREPRS + enterprise!['id'],
    data: enterprise,
  );

  response = await httpPutWithToken(
    endPoint: APIURL.EDITADDRESS + address!['id'],
    data: address,
  );

  response = await httpPutWithToken(
    endPoint: APIURL.EDITBANK + bank!['id'],
    data: bank,
  );

  return response;
}
