import 'package:mmt_club/Models/Project/level_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'gifts_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  int id;
  String fullName;
  String username;
  double points;
  LevelModel? level;
  List<GiftsModel>? gifts;

  ProfileModel(this.id, this.fullName, this.username, this.points, this.level,
      this.gifts);

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
