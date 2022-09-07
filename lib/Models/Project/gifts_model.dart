import 'package:json_annotation/json_annotation.dart';
part 'gifts_model.g.dart';

@JsonSerializable()
class GiftsModel {
  int id;
  String name;
  String? description;
  String? image;
  bool isActive;

  GiftsModel(this.id, this.name, this.description, this.image, this.isActive);
  factory GiftsModel.fromJson(Map<String, dynamic> json) =>
      _$GiftsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GiftsModelToJson(this);
}
