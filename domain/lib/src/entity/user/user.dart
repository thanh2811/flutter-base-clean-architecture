import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@unfreezed
class UserEntity with _$UserEntity {
  factory UserEntity({
    String? id,
    String? fullname,
    String? avatar,
    String? coverImage,
    String? position,
    String? company,
    String? userMembership,
    String? product,
    String? bio,
    bool? showProduct,
    bool? showBio,
    int? membershipType,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
