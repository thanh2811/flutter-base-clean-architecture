import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

enum RestMethod { get, post, put, patch, delete }

class BaseRestApiClient {
  final Dio dio;

  BaseRestApiClient({required this.dio});

  Future<T?> reuqest<D, T>({
    required RestMethod restMethod,
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Decoder<D>? decoder,
    Options? options,
  }) async {
    return null;
  }
}
