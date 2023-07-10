import 'package:json_annotation/json_annotation.dart';
import 'error_response.dart';

part 'base_response.g.dart';

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

@JsonSerializable(genericArgumentFactories: true)
class DefaultResponse<T> {
  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'statusCode')
  final int statusCode;
  @JsonKey(name: 'messages')
  final List<dynamic>? messages;
  @JsonKey(name: 'data')
  final T? data;

  DefaultResponse(this.success, this.statusCode, this.messages, this.data);

  factory DefaultResponse.fromJson(Map<String, dynamic> json,
          T Function(Object? json) fromJsonCallBack) =>
      _$DefaultResponseFromJson(json, fromJsonCallBack);
}
