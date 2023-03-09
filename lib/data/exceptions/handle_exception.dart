import 'dart:developer';
import 'dart:io';

import 'package:base_project/main.dart';
import 'package:base_project/shared/utils/dialog_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/model/api/error_response.dart';
import 'app_exception.dart';

void handleException(
  Object e, {
  Function()? popupCallback,
  Function(DioError err)? errorCallback,
  Function(int? statusCode, ErrorResponse err)? errCallback,
}) async {
  String message = '';
  log(e.runtimeType.toString());
  switch (e.runtimeType) {
    case SocketException:
      message = 'Không có kết nối mạng';
      break;

    case DioError:
      e as DioError;
      var dioError =
          _parseDioError(e, (err) => null, (statusCode, err) => null);
      message = dioError ?? '';
      break;

    case AppException:
      e as AppException;
      message = e.message;
      break;
    case Response:
      message = 'Đã xảy ra lỗi, vui lòng thử lại sau!';
      break;
    default:
      message = 'Đã xảy ra lỗi, vui lòng thử lại sau!';
  }

  if (message.isNotEmpty) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => getErrorDialog(
        context: context,
        message: message,
      ),
    );
  }
}

dynamic _parseDioError(
  DioError err,
  Function(DioError err)? errorCallback,
  Function(int? statusCode, ErrorResponse err)? errCallback,
) {
  try {
    if (err.error is SocketException) {
      if(err.message.contains("Failed host lookup")) {
        return "Đã xảy ra lỗi. Vui lòng thử lại sau!";
      }
      return 'Không có kết nối mạng. Vui lòng kiểm tra lại';
    }

    if (err.type == DioErrorType.connectTimeout) {
      return 'Kết nối mạng không ổn định. Vui lòng kiểm tra lại';
    }

    if (err.type == DioErrorType.cancel) {
      return err.message;
    }

    var error = ErrorResponse.fromJson(err.response?.data);
    switch (err.response?.statusCode) {
      case 404:
        return error.status;
      default:
        errCallback?.call(err.response?.statusCode, error);
        errorCallback?.call(err);
    }

    if (errCallback != null) return;
    return error.status;
  } catch (e) {
    return e.toString();
  }
}
