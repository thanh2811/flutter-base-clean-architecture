import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../data/constants.dart';

class ReportApi {
  final Dio dio;

  ReportApi(
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

  Future<Response> getSaleCustomer(
      {String? fromDate, String? toDate, int? pageNum, int? pageSize}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getSaleCustomer,
      data: jsonEncode({
        "fromDate": fromDate,
        "toDate": toDate,
        "page": pageNum,
        "pageSize": pageSize,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

  Future<Response> getSaleProduct(
      {String? fromDate, String? toDate, int? pageNum, int? pageSize}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getSaleProduct,
      data: jsonEncode({
        "fromDate": fromDate,
        "toDate": toDate,
        "page": pageNum,
        "pageSize": pageSize,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

  Future<Response> getOrderCustomer(
      {String? fromDate, String? toDate, int? pageNum, int? pageSize}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getOrderCustomer,
      data: jsonEncode({
        "fromDate": fromDate,
        "toDate": toDate,
        "page": pageNum,
        "pageSize": pageSize,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

  Future<Response> getOrderProduct(
      {String? fromDate, String? toDate, int? pageNum, int? pageSize}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getOrderProduct,
      data: jsonEncode({
        "fromDate": fromDate,
        "toDate": toDate,
        "page": pageNum,
        "pageSize": pageSize,
      }),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

}
