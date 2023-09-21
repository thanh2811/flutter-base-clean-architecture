import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'mapper/user_data_mapper.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  RepositoryImpl(this._userDataMapper);
  final UserDataMapper _userDataMapper;
  @override
  Future<UserEntity> getUserSSO() async {
    _userDataMapper;
    return UserEntity();
  }
}
