import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../data/constants.dart';
import '../di/network_injection.dart';

class AppApi {
  final Dio dio;
  final SharedPreferences sharedPreferences = getIt.get<SharedPreferences>();
  String idToken = '';
  AppApi(
    this.dio,
  ) {
    dio.interceptors.add(PrettyDioLogger(
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
    dio.options = options;
  }

  Future<Response> getCustomerInfo({required String id}) async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.get(
      EndPoints.getCustomerInfo,
      queryParameters: {
        'Id': id,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getCustomerType() async {
    String idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.get(
      EndPoints.getCustomerType,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> searchCustomer(
      {String? keyword, int? pageNum, int? pageSize}) async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.post(
      EndPoints.getAllCustomer,
      data: {
        "keyword": keyword ?? '',
        "page": pageNum,
        "pageSize": pageSize,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getCustomerGroup() async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.get(
      EndPoints.getCustomerGroup,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getCustomerChannel() async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.get(
      EndPoints.getCustomerChannel,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> addNewCustomer({required data}) async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.post(
      EndPoints.addNewCustomer,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> updateCustomer({required data}) async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.put(
      EndPoints.updateCustomer,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );

    return response;
  }

  Future<Response> getRouteByCustomerId({required id}) async {
    final sharedPref = await SharedPreferences.getInstance();
    final String? accessToken =
        sharedPref.getString(SharedPreferenceKey.idToken);
    final response = await dio.get(
      EndPoints.getRouteByCustomerId,
      queryParameters: {
        "Id": id,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    return response;
  }

  Future<Response> getRouteByEmployeeId() async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    String employeeId =
        sharedPreferences.getString(SharedPreferenceKey.employeeId).toString();
    final response = await dio.get(EndPoints.getRouteByEmployeeId,
        options: Options(
          headers: {'Authorization': 'Bearer $idToken'},
        ),
        queryParameters: {
          // "keyword": keyword ?? '',
          "EmployeeId": employeeId,
          "page": 1,
          "pageSize": 1000,
        });
    return response;
  }

  Future<Response> getAllAlbums() async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.get(
      EndPoints.getAllAlbums,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }

  Future<Response> addCheckIn({required data}) async {
    idToken =
        sharedPreferences.getString(SharedPreferenceKey.idToken).toString();
    final response = await dio.post(
      EndPoints.addCheckIn,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $idToken'},
      ),
    );
    return response;
  }
}
