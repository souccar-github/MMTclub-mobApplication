import 'package:json_annotation/json_annotation.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int id;
  String name;
  String? description;
  String? image;
  double point;
  int? parentCategoryId;
  List<CategoryNewsModel>? news;
  CategoryModel(this.id, this.name, this.description, this.image, this.point,
      this.parentCategoryId, this.news);
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
