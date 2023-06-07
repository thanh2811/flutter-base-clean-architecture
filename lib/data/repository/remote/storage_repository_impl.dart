import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../constant/enum.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../interceptor/dio_base_options.dart';
import '../local/local_data_access.dart';
import 'storage_repository.dart';

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
    dio.options =
        DioBaseOptions(baseUrl: Environment.resourcesBaseUrl).baseOption;
  }

  @override
  Future<ResponseWrapper<String>> uploadImage(
      {required String imagePath, ImageType imageType = ImageType.none}) async {
    final String accessToken = await localDataAccess.getAccessToken();
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
      case ImageType.square:
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
          ), onSendProgress: (progress, total) {
        log('onSendProgress $progress / $total');
      }, onReceiveProgress: (progress, total) {
        log('onReceiveProgress $progress / $total');
      });
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
  Future<ResponseWrapper<List<String>>> uploadMultipleImage(
      {required List<String> imagePathList}) async {
    final String accessToken = await localDataAccess.getAccessToken();

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
    try {
      final response = await dio.put(
        EndPoints.uploadImage,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.statusCode == 200) {
        log('response.data: ${response.data.runtimeType}');
        return ResponseWrapper.success(data: List<String>.from(response.data));
      }
      return ResponseWrapper.error(message: '');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
  }
}
