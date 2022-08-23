part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductsEvent {
  final int? catID;
  final String? keyword;
  const GetAllProductsEvent({this.catID, this.keyword});
}
