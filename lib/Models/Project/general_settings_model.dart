import 'package:json_annotation/json_annotation.dart';

part 'general_settings_model.g.dart';

@JsonSerializable()
class GeneralSettingModel {
  String? facebook;
  String? instagram;
  String? youTube;
  String? telegram;
  String? mobilePhone;

  GeneralSettingModel(this.facebook, this.instagram, this.youTube,
      this.telegram, this.mobilePhone);

  factory GeneralSettingModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralSettingModelToJson(this);
}
