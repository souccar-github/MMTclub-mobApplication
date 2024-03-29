import 'package:json_annotation/json_annotation.dart';

import 'gifts_model.dart';
part 'level_model.g.dart';

@JsonSerializable()
class LevelModel {
  int id;
  String name;
  String? description;
  double fromPoint;
  double toPoint;
  String color;
  List<GiftsModel>? gifts;

  LevelModel(this.id, this.name, this.description, this.fromPoint, this.toPoint,
      this.color, this.gifts);

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
