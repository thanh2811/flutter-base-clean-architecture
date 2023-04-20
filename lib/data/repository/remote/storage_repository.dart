import '../../constant/enum.dart';
import '../../model/api/base_response.dart';

abstract class StorageRepository {
  Future<ResponseWrapper<String>> uploadImage(
      {required String imagePath, ImageType imageType = ImageType.none});

  Future<ResponseWrapper<List<String>>> uploadMultipleImage(
      {required List<String> imagePathList});
}
