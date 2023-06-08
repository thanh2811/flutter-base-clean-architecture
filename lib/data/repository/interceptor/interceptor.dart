import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../main.dart';
import '../../../shared/utils/dialog_helper.dart';
import '../../../view/auth/login/login_page.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../local/local_data_access.dart';
import '../remote/repository.dart';

class AppInterceptor {
  final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();
  final OpenIDRepository openIdRepository = getIt.get<OpenIDRepository>();

  AppInterceptor();

  QueuedInterceptorsWrapper queueInterceptor({required Dio dio}) =>
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(options);
          // check access token is retrieved?
        },
        onResponse: (response, handler) {
          log('onResponse: ${response.requestOptions.path} \n  $response');
          handler.next(response);
        },
        onError: (error, handler) async {
          log('onError: $error \n');
          if (error.response?.statusCode == 401) {
            log('onError: refreshing...');
            final response = await openIdRepository.refreshToken();
            if (response.status == ResponseStatus.success) {
              log('onError: refreshed...');
              final opts = Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers);
              return handler.resolve(await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters));
            } else {
              showGlobalDialog(
                  message:
                      'Phiên đăng nhập của bạn đã hết hạn. Vui lòng đăng nhập lại để tiếp tục sử dụng',
                  callbackWhenDismiss: (value) {
                    navigatorKey.currentState?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                    );
                  });
              localDataAccess.clearAccessToken();
              localDataAccess.clearRefreshToken();
              return handler.next(error);
            }
          } else {
            handleException(error);
          }
        },
      );
}
