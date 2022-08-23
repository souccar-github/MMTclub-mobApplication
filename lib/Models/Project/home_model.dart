import 'package:json_annotation/json_annotation.dart';
import 'package:mmt_club/Models/Project/category_model.dart';
import 'level_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  final String? fullName;
  final String? username;
  final double? points;
  final LevelModel? level;
  final List<CategoryModel>? categories;

  HomeModel(
      this.fullName, this.username, this.points, this.level, this.categories);
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
