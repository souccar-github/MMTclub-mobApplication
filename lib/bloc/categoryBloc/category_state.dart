part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class GetCategoryError extends CategoryInitial {
  final String error;

  GetCategoryError(this.error);
}

class GetCategorySuccessfully extends CategoryInitial {
  final List<CategoryModel> cats;

  GetCategorySuccessfully(this.cats);
}

class GetCategoryWaiting extends CategoryInitial {}
