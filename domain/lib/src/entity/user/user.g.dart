// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntity _$$_UserEntityFromJson(Map<String, dynamic> json) =>
    _$_UserEntity(
      id: json['id'] as String?,
      fullname: json['fullname'] as String?,
      avatar: json['avatar'] as String?,
      coverImage: json['coverImage'] as String?,
      position: json['position'] as String?,
      company: json['company'] as String?,
      userMembership: json['userMembership'] as String?,
      product: json['product'] as String?,
      bio: json['bio'] as String?,
      showProduct: json['showProduct'] as bool?,
      showBio: json['showBio'] as bool?,
      membershipType: json['membershipType'] as int?,
    );

Map<String, dynamic> _$$_UserEntityToJson(_$_UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'coverImage': instance.coverImage,
      'position': instance.position,
      'company': instance.company,
      'userMembership': instance.userMembership,
      'product': instance.product,
      'bio': instance.bio,
      'showProduct': instance.showProduct,
      'showBio': instance.showBio,
      'membershipType': instance.membershipType,
    };
