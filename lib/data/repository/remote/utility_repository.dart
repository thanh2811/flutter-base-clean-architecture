import '../../model/api/base_response.dart';
import '../../model/public_api/location.dart';

abstract class UtilityRepository {
  Future<ResponseWrapper<List<Province>>> getProvincesList();

  Future<ResponseWrapper<List<District>>> getDistrictsList({required int code});

  Future<ResponseWrapper<List<Ward>>> getCommunesList(
      {required int provinceCode, required int districtId});
}
