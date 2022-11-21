import 'package:dio/dio.dart';

import '../../services/app_service.dart';

class AppRepository {
  final AppApi api;

  AppRepository({required this.api});

  Future<Response> getCustomerInfo({required String id}) =>
      api.getCustomerInfo(id: id);
  Future<Response> addNewCustomer({required dynamic data}) =>
      api.addNewCustomer(data: data);
  Future<Response> updateCustomer({required dynamic data}) =>
      api.updateCustomer(data: data);
  Future<Response> searchCustomer(
          {String? keyword, int? pageNum, int? pageSize}) =>
      api.searchCustomer(
          keyword: keyword, pageNum: pageNum, pageSize: pageSize);
  Future<Response> getCustomerType() => api.getCustomerType();
  Future<Response> getCustomerGroup() => api.getCustomerGroup();
  Future<Response> getCustomerChannel() => api.getCustomerChannel();

  Future<Response> getRouteByCustomerId({required id}) =>
      api.getRouteByCustomerId(id: id);

  Future<Response> getRouteByEmployeeId() => api.getRouteByEmployeeId();

  Future<Response> getAllAlbums() => api.getAllAlbums();

  Future<Response> addCheckIn(dynamic data) => api.addCheckIn(data: data);
}
