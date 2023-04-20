import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../model/api/base_response.dart';
import '../interceptor/dio_base_options.dart';
import '../local/local_data_access.dart';
import 'repository.dart';

class AppRepositoryImpl implements AppRepository {
  final Dio dio;
  final LocalDataAccess localDataAccess;
  final OpenIDRepository openIdRepository;

  AppRepositoryImpl({
    required this.dio,
    required this.localDataAccess,
    required this.openIdRepository,
  }) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));

    // interceptor
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        handler.next(options);
        // check access token is retrieved?
      },
      onResponse: (response, handler) {
        log('onResponse: ${response.requestOptions.path} \n  $response');
        handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final response = await openIdRepository.refreshToken();
          if (response.status == ResponseStatus.success) {
            final opts = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers);
            return handler.resolve(await dio.request(error.requestOptions.path,
                options: opts,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters));
          } else {
            return handler.next(error);
          }
        }
      },
    ));
    dio.options =
        DioBaseOptions(baseUrl: Environment.resourcesBaseUrl).baseOption;
  }
}
