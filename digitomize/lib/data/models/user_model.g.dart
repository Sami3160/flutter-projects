// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  address: json['address'] as String?,
  institute: json['institute'] as String?,
  bio: json['bio'] as String?,
  lcUsername: json['lcUsername'] as String?,
  profileUrl: json['profileUrl'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'address': instance.address,
  'institute': instance.institute,
  'bio': instance.bio,
  'lcUsername': instance.lcUsername,
  'profileUrl': instance.profileUrl,
};
