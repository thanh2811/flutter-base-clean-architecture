import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../data/constants.dart';

class ProductApi {
  final Dio dio;

  ProductApi(
    Dio? dio,
  ) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.appBaseUrl,
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

  Future<Response> getSalePointsList() async {
    return Response(requestOptions: RequestOptions(path: ''));
  }

  // String idToken =
  // sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyIiwiYXV0aCI6IlJPTEVfVVNFUiIsInNpZCI6InVzZXItMyIsIm5iZiI6MTY2NTcyMzkwOCwiZXhwIjoxNjY4MzE1OTA4LCJpYXQiOjE2NjU3MjM5MDh9._aWEE0xvciSR_uLqIJl6CG7yicPurgcshPaGTHqPGNg';

  Future<Response> getCatalogList(
      {String? keyword, int? pageNum, int? pageSize}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getCatalogActiveList,
      data: jsonEncode({
        "keyword": keyword,
        "sortBy": {"property": "STT", "value": true},
        "page": pageNum,
        "pageSize": pageSize,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

  Future<Response> getAllUnit() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(
      EndPoints.getAllUnit,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }
}
