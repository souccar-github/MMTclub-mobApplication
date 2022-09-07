// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      json['fullName'] as String?,
      json['username'] as String?,
      (json['userPoints'] as num?)?.toDouble(),
      json['level'] == null
          ? null
          : LevelModel.fromJson(json['level'] as Map<String, dynamic>),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'username': instance.username,
      'userPoints': instance.userPoints,
      'level': instance.level,
      'categories': instance.categories,
    };
