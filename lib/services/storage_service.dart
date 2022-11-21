import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/config.dart';
import '../data/repository/local/shared_pref_helper.dart';
import '../di/network_injection.dart';

class StorageApi {
  final Dio dio;

  StorageApi(
    Dio? dio,
  ) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.cdnBaseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    this.dio.options = options;
  }

  Future<Response> uploadImage({required String imagePath}) async {
    final String accessToken = getIt.get<SharePrefHelper>().getAccessToken();

    var formData = FormData.fromMap({
      // 'type': 'DisplayProduct',
      'file': await MultipartFile.fromFile(imagePath)
    });
    final response = await dio.post(
      EndPoints.uploadImage,
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    return response;
  }

  Future<Response> uploadMutipleImage(
      {required List<String> imagePathList}) async {
    final String accessToken = getIt.get<SharePrefHelper>().getAccessToken();

    var formData = FormData();
    for (String path in imagePathList) {
      formData.files.add(
        MapEntry('file', await MultipartFile.fromFile(path)),
      );
    }
    // .fromMap({
    //   // 'type': 'DisplayProduct',
    //   'file': await MultipartFile.fromFile(imagePath)
    // });
    final response = await dio.post(
      EndPoints.uploadImage,
      data: formData,
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    return response;
  }
}
