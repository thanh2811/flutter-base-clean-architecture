import 'error_response.dart';

class ResponseWrapper<T> {
  final ResponseStatus status;
  final T? data;
  final String? message;
  final ErrorResponse? errorResponse;
  final int? statusCode;

  ResponseWrapper(
      {required this.status,
      this.data,
      this.message,
      this.errorResponse,
      this.statusCode});

  factory ResponseWrapper.success({required T data}) =>
      ResponseWrapper(status: ResponseStatus.success, data: data);

  factory ResponseWrapper.error(
          {required String message, int? statusCode, T? data}) =>
      ResponseWrapper(
          status: ResponseStatus.error,
          data: data,
          message: message,
          statusCode: statusCode);
}

enum ResponseStatus {
  success,
  error,
  loading,
}

class DefaultResponse<T> {
  final bool success;
  final T? data;
  final String errorMessage;
  final int? errorCode;

  DefaultResponse(this.success, this.data, this.errorMessage, this.errorCode);
}
