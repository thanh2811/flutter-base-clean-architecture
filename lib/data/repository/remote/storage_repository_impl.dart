import 'dart:async';

import 'package:base_project/data/repository/local/local_data_access.dart';
import 'package:base_project/data/repository/remote/storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../constant/enum.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';

class StorageRepositoryImpl implements StorageRepository {
  final Dio dio;
  final LocalDataAccess localDataAccess;

  StorageRepositoryImpl({
    required this.dio,
    required this.localDataAccess,
  }) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: Environment.cdnBaseUrl,
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
    dio.options = options;
  }

  @override
  Future<ResponseWrapper<String>> uploadImage(
      {required String imagePath, ImageType imageType = ImageType.none}) async {
    final String accessToken = localDataAccess.getAccessToken();
    String imageTypeStr = '';
    switch (imageType) {
      case ImageType.none:
        break;
      case ImageType.avatar:
        imageTypeStr = 'Avatar';
        break;
      case ImageType.cover:
        imageTypeStr = 'CoverImage';
        break;
    }

    var formData = FormData.fromMap({
      'type': imageTypeStr,
      'file': await MultipartFile.fromFile(imagePath)
    });
    try {
      final response = await dio.put(EndPoints.uploadImage,
          data: formData,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
          onSendProgress: (progress, total) {},
          onReceiveProgress: (progress, total) {});
      if (response.statusCode == 200) {
        return ResponseWrapper.success(data: (response.data as List)[0]);
      }
      return ResponseWrapper.error(message: '');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }

  @override
  Future<Response> uploadMultipleImage(
      {required List<String> imagePathList}) async {
    final String accessToken = localDataAccess.getAccessToken();

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
