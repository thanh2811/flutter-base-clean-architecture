import 'package:dio/dio.dart';

import '../../services/product_service.dart';

class ProductRepository {
  final ProductApi api;

  ProductRepository({required this.api});

  Future<Response> getSalePointsList() => api.getSalePointsList();
  Future<Response> getCatalogList(
          {String? keyword, int? pageNum, int? pageSize}) =>
      api.getCatalogList(
          keyword: keyword, pageNum: pageNum, pageSize: pageSize);
  Future<Response> getAllUnit() => api.getAllUnit();
}
