part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class GetAllProductsError extends ProductsInitial {
  final String error;

  GetAllProductsError(this.error);
}

class GetAllProductsSuccessfully extends ProductsInitial {
  final List<ProductDetailsModel> productDetailsModels;

  GetAllProductsSuccessfully(this.productDetailsModels);
}

class GetAllProductsWaiting extends ProductsInitial {}
