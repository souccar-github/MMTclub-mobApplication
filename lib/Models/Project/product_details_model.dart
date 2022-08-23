import 'package:json_annotation/json_annotation.dart';
import 'package:mmt_club/Models/Project/category_model.dart';
part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  String name;
  String description;
  double point;
  String firstImage;
  String secondImage;
  String thirdImage;
  CategoryModel? category;
  int categoryId;
  int id;

  ProductDetailsModel(
      this.name,
      this.description,
      this.point,
      this.firstImage,
      this.secondImage,
      this.thirdImage,
      this.category,
      this.categoryId,
      this.id);

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}
