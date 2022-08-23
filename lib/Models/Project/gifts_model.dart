import 'package:json_annotation/json_annotation.dart';
part 'gifts_model.g.dart';

@JsonSerializable()
class GiftsModel {
  int id;
  String name;
  String description;
  String? image;
  int levelId;

  GiftsModel(this.id, this.name, this.description, this.image, this.levelId);
  factory GiftsModel.fromJson(Map<String, dynamic> json) =>
      _$GiftsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GiftsModelToJson(this);
}
