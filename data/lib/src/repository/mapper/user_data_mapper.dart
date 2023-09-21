import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../model/sso/user_sso.dart';
import 'base/base_data_mapper.dart';

@injectable
class UserDataMapper extends BaseDataMapper<UserSSOResponse, UserEntity> {
  @override
  UserEntity mapToEntity(UserSSOResponse? data) {
    return UserEntity(
      fullname: data?.user?.displayName,
      id: data?.user?.idString,
    );
  }
}
