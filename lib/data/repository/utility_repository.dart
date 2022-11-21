import 'package:dio/dio.dart';

import '../../services/utility_service.dart';

class UtilityRepository {
  final UtilitiesApi api;

  UtilityRepository({required this.api});

  Future<Response> getProvincesList() => api.getProvincesList();
  Future<Response> getDistrictsList({required int code}) =>
      api.getDistrictsList(code);
  Future<Response> getCommunesList({required int code}) =>
      api.getCommunesList(code);
  // Future<Response> getProvincesList() => api.getProvincesList();
}
