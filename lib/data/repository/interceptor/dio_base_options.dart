import 'package:dio/dio.dart';

class DioBaseOptions {
  late BaseOptions baseOption;

  DioBaseOptions({required String baseUrl}) {
    baseOption = BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 400;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
  }
}
