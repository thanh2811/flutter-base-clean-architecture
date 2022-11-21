import 'package:dio/dio.dart';

import '../../services/storage_service.dart';

class StorageRepository {
  final StorageApi storageApi;

  StorageRepository({required this.storageApi});

  Future<Response> uploadImage({required String imagePath}) =>
      storageApi.uploadImage(imagePath: imagePath);
  Future<Response> uploadMutipleImage({required List<String> imagePathList}) =>
      storageApi.uploadMutipleImage(imagePathList: imagePathList);
}
