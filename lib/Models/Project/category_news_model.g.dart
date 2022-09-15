// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryNewsModel _$CategoryNewsModelFromJson(Map<String, dynamic> json) =>
    CategoryNewsModel(
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$CategoryNewsModelToJson(CategoryNewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
