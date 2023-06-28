import 'dart:async';

import '../interceptor/dio_base_options.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../exceptions/handle_exception.dart';
import '../../model/api/base_response.dart';
import '../../model/public_api/location.dart';
import 'repository.dart';

class UtilitiesRepositoryImpl implements UtilityRepository {
  final Dio dio;

  UtilitiesRepositoryImpl({required this.dio}) {
    dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    dio.options =
        DioBaseOptions(baseUrl: EndPoints.publicAddressBaseUrl).baseOption;
  }

  @override
  Future<ResponseWrapper<List<Province>>> getProvincesList() async {
    try {
      final response = await dio.get('/');
      List<Province> provincesList = [];
      if (response.statusCode == 200) {
        provincesList = List<Province>.from(
            (response.data as List).map((model) => Province.fromJson(model)));
      }
      return ResponseWrapper.success(data: provincesList);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: "", data: []);
    }
  }

  @override
  Future<ResponseWrapper<List<District>>> getDistrictsList(
      {required int code}) async {
    final response = await dio.get('/$code?depth=2');
    try {
      List<District> districtList = [];
      if (response.statusCode == 200) {
        districtList = Province.fromJson(response.data).districts ?? [];
        return ResponseWrapper.success(data: districtList);
      }
      return ResponseWrapper.error(data: [], message: "");
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(data: [], message: "");
    }
  }

  @override
  Future<ResponseWrapper<List<Ward>>> getCommunesList(
      {required int provinceCode, required int districtId}) async {
    final response = await dio.get('/$provinceCode?depth=3');
    try {
      List<Ward> communeList = [];
      if (response.statusCode == 200) {
        communeList = Province.fromJson(response.data)
                .districts
                ?.where((element) => element.code == districtId)
                .first
                .wards ??
            [];
        return ResponseWrapper.success(data: communeList);
      }
      return ResponseWrapper.error(message: '');
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '');
    }
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
