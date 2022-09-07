// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      json['id'] as int,
      json['fullName'] as String,
      json['username'] as String,
      (json['userPoints'] as num).toDouble(),
      json['level'] == null
          ? null
          : LevelModel.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'userPoints': instance.userPoints,
      'level': instance.level,
    };
