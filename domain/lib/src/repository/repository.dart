import '../entity/user/user.dart';

abstract class Repository {
  Future<UserEntity> getUserSSO();
}
