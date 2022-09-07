// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftsModel _$GiftsModelFromJson(Map<String, dynamic> json) => GiftsModel(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String?,
      json['image'] as String?,
      json['isActive'] as bool,
    );

Map<String, dynamic> _$GiftsModelToJson(GiftsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'isActive': instance.isActive,
    };
