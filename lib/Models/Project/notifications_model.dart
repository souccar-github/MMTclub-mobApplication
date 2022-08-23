import 'package:json_annotation/json_annotation.dart';
part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationsModel {
  int id;
  String title;
  String body;
  int distType;
  int distId;
  bool isRead;

  NotificationsModel(
      this.id, this.title, this.body, this.distType, this.distId, this.isRead);
  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);
}
