import 'package:dio/dio.dart';

abstract class StorageRepository {
  Future<Response> uploadImage({required String imagePath});
  Future<Response> uploadMultipleImage({required List<String> imagePathList});
}
