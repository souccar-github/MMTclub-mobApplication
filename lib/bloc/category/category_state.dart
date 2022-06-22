part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySuccess extends CategoryState {}

class CategoryFailure extends CategoryState {}
