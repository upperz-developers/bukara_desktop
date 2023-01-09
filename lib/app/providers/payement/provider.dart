import 'package:bukara/app/services/http/dio_service.dart';
import 'package:dio/dio.dart';

import '../../services/shared/api_url.dart';

Future<Response> getPayement() async => await httpGetWithToken(
      endPoint: APIURL.GETPAYEMENT,
    );
