import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../data/constants.dart';

class OrderApi {
  final Dio dio;

  OrderApi(
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

  Future<Response> addPurchaseOrder({required dynamic data}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.addPurchaseOrder,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> addReturnOrder({required dynamic data}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.addReturnOrder,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getOrders(
      {String? keyword,
      int? pageNum,
      int? pageSize,
      int? receiptType,
      int? status,
      String? startDate,
      String? endDate}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.post(
      EndPoints.getOrders,
      data: jsonEncode({
        "keyword": keyword,
        "sortField": "CreatedDate",
        "isAscending": false,
        "status": status,
        "receiptType": receiptType ?? 1,
        "fromDate": startDate,
        "toDate": endDate,
        "page": pageNum,
        "pageSize": pageSize,
      }..removeWhere((key, value) => value == null || value == "")),
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getAllWarehouse() async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(
      EndPoints.getAllWarehouse,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getOrderDetail({required id}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? idToken = sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(
      EndPoints.getOrderDetail,
      queryParameters: {
        "Id": id,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }
}
