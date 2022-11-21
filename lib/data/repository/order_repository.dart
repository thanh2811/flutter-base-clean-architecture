import 'package:dio/dio.dart';

import '../../services/order_service.dart';

class OrderRepository {
  final OrderApi api;

  OrderRepository({required this.api});
  Future<Response> addPurchaseOrder({required dynamic data}) =>
      api.addPurchaseOrder(data: data);

  Future<Response> addReturnOrder({required dynamic data}) =>
      api.addReturnOrder(data: data);

  Future<Response> getOrders(
          {String? keyword,
          int? pageNum,
          int? pageSize,
          int? status,
          int? receiptType,
          String? startDate,
          String? endDate}) =>
      api.getOrders(
          keyword: keyword,
          pageNum: pageNum,
          pageSize: pageSize,
          status: status,
          receiptType: receiptType,
          startDate: startDate,
          endDate: endDate);

  Future<Response> getAllWarehouse() => api.getAllWarehouse();

  Future<Response> getOrderDetail({required String id}) =>
      api.getOrderDetail(id: id);
}
