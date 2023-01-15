import 'package:bukara/app/services/http/dio_service.dart';
import 'package:bukara/app/services/shared/api_url.dart';
import 'package:dio/dio.dart';

Future<Response> breakContrat({String? contratId, String? tenantId}) async =>
    await httpPostWithToken(endPoint: APIURL.BREACKCONTRAT + contratId!, data: {
      "landlordId": tenantId,
    });
