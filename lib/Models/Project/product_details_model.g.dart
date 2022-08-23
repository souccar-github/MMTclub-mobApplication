// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      json['name'] as String,
      json['description'] as String,
      (json['point'] as num).toDouble(),
      json['firstImage'] as String,
      json['secondImage'] as String,
      json['thirdImage'] as String,
      json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      json['categoryId'] as int,
      json['id'] as int,
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'point': instance.point,
      'firstImage': instance.firstImage,
      'secondImage': instance.secondImage,
      'thirdImage': instance.thirdImage,
      'category': instance.category,
      'categoryId': instance.categoryId,
      'id': instance.id,
    };
