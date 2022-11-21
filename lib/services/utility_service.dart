import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/config.dart';

class UtilitiesApi {
  final Dio dio;

  UtilitiesApi(this.dio) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.publicAddressbaseUrl,
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

  Future<Response> getProvincesList() async {
    final response = await dio.get('/');
    return response;
  }

  Future<Response> getDistrictsList(int code) async {
    final response = await dio.get('/$code?depth=2');
    return response;
  }

  Future<Response> getCommunesList(int provinceCode) async {
    final response = await dio.get('/$provinceCode?depth=3');
    return response;
  }

  // getCommunesList(String? name,List<District> provincesList) async {
  //   int? index = 1;
  //   for (var i in listDistricts) {
  //     if (i.name == name) {
  //       index = i.code;
  //     }
  //   }
  //   var url = Uri.parse('https://provinces.open-api.vn/api/d/$index?depth=2');
  //   var response = await http.get(url, headers: {
  //     "Accept": "application/json",
  //     "content-type": "application/json"
  //   });
  //   District district =
  //       District.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  //   listCommunes = district.wards!;
  //   commune ??= listCommunes[0].name;
  //   setState(() {});
  // }
}
