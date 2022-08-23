// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['userNameOrEmailAddress'] as String,
      json['password'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'userNameOrEmailAddress': instance.userNameOrEmailAddress,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
    };
