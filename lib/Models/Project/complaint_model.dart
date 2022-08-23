import 'package:json_annotation/json_annotation.dart';

part 'complaint_model.g.dart';

@JsonSerializable()
class ComplaintModel {
  String title;
  String description;

  ComplaintModel(this.title, this.description);

  factory ComplaintModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintModelToJson(this);
}
