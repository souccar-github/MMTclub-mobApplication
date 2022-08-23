import 'package:json_annotation/json_annotation.dart';

part 'complaint_feedback_model.g.dart';

@JsonSerializable()
class ComplaintFeedbackModel {
  String title;
  String body;
  ComplaintFeedbackModel(this.title, this.body);

  factory ComplaintFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintFeedbackModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintFeedbackModelToJson(this);
}
