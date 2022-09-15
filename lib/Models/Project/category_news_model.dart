import 'package:json_annotation/json_annotation.dart';
part 'category_news_model.g.dart';

@JsonSerializable()
class CategoryNewsModel {
  int? id;
  String? title;
  String? description;
  String? image;

  CategoryNewsModel(this.id, this.title, this.description, this.image);
  factory CategoryNewsModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryNewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryNewsModelToJson(this);
}
