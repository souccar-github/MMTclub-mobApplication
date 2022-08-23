// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['image'] as String,
      (json['point'] as num).toDouble(),
      json['parentCategoryId'] as int?,
      (json['news'] as List<dynamic>?)
          ?.map((e) => CategoryNewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'point': instance.point,
      'parentCategoryId': instance.parentCategoryId,
      'news': instance.news,
    };
