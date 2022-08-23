import 'package:json_annotation/json_annotation.dart';

import 'gifts_model.dart';
part 'level_model.g.dart';

@JsonSerializable()
class LevelModel {
  int id;
  String name;
  String description;
  double point;
  String color;
  List<GiftsModel>? gifts;

  LevelModel(
      this.id, this.name, this.description, this.point, this.color, this.gifts);

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
