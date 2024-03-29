// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => LevelModel(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String?,
      (json['fromPoint'] as num).toDouble(),
      (json['toPoint'] as num).toDouble(),
      json['color'] as String,
      (json['gifts'] as List<dynamic>?)
          ?.map((e) => GiftsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'fromPoint': instance.fromPoint,
      'toPoint': instance.toPoint,
      'color': instance.color,
      'gifts': instance.gifts,
    };
