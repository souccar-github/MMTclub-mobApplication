// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralSettingModel _$GeneralSettingModelFromJson(Map<String, dynamic> json) =>
    GeneralSettingModel(
      json['facebook'] as String,
      json['instagram'] as String,
      json['youTube'] as String,
      json['telegram'] as String,
      json['twitter'] as String,
    );

Map<String, dynamic> _$GeneralSettingModelToJson(
        GeneralSettingModel instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'youTube': instance.youTube,
      'telegram': instance.telegram,
      'twitter': instance.twitter,
    };
