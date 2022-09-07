import 'package:mmt_club/Models/Project/level_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  int id;
  String fullName;
  String username;
  double userPoints;
  LevelModel? level;

  ProfileModel(
      this.id, this.fullName, this.username, this.userPoints, this.level);

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
