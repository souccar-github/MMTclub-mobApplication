// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) =>
    NotificationsModel(
      json['id'] as int,
      json['title'] as String,
      json['body'] as String,
      json['distType'] as int,
      json['distId'] as int,
      json['isRead'] as bool,
    );

Map<String, dynamic> _$NotificationsModelToJson(NotificationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'distType': instance.distType,
      'distId': instance.distId,
      'isRead': instance.isRead,
    };
