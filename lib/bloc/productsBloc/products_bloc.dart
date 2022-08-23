import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/API/Project/project.dart';
import '../../Models/Project/product_details_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetAllProductsEvent) {
        emit(GetAllProductsWaiting());
        await Project.apiClient
            .getAllProducts(catID: event.catID, keyWord: event.keyword)
            .then(
              (productDetailsModel) => emit(
                GetAllProductsSuccessfully(productDetailsModel),
              ),
            )
            .catchError((error) {
          emit(
            GetAllProductsError(
              error.toString(),
            ),
          );
        });
      }
    });
  }
}
