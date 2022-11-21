import 'package:dio/dio.dart';

import '../../services/report_service.dart';

class ReportRepository {
  final ReportApi api;

  ReportRepository({required this.api});
  Future<Response> getSaleCustomer(
          {String? fromDate, String? toDate, int? pageNum, int? pageSize}) =>
      api.getSaleCustomer(
          fromDate: fromDate,
          toDate: toDate,
          pageNum: pageNum,
          pageSize: pageSize);

  Future<Response> getSaleProduct(
          {String? fromDate, String? toDate, int? pageNum, int? pageSize}) =>
      api.getSaleProduct(
          fromDate: fromDate,
          toDate: toDate,
          pageNum: pageNum,
          pageSize: pageSize);

  Future<Response> getOrderCustomer(
          {String? fromDate, String? toDate, int? pageNum, int? pageSize}) =>
      api.getOrderCustomer(
          fromDate: fromDate,
          toDate: toDate,
          pageNum: pageNum,
          pageSize: pageSize);

  Future<Response> getOrderProduct(
          {String? fromDate, String? toDate, int? pageNum, int? pageSize}) =>
      api.getOrderProduct(
          fromDate: fromDate,
          toDate: toDate,
          pageNum: pageNum,
          pageSize: pageSize);
}
