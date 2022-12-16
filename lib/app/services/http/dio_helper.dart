import 'package:bukara/app/services/http/interceptor.dart';
import 'package:dio/dio.dart';

class DioApi {
  late final Dio dio = createDio();
  DioApi._internal();
  static final singleton = DioApi._internal();
  factory DioApi() => singleton;
  Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: 15000, // for 15 seconds
        receiveTimeout: 15000,
        sendTimeout: 15000,
      ),
    );
    dio.interceptors.add(ApiInterceptor(dio));
    return dio;
  }
}
