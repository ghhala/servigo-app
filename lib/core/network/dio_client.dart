import 'package:dio/dio.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2/servigo/public/api/',

      //baseUrl: 'http://192.168.1.3/servigo/public/api/',
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
    ),
  );
  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
