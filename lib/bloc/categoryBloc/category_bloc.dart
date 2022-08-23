import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/category_model.dart';

import '../../API/Project/project.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetCategoryEvent) {
        emit(GetCategoryWaiting());
        await Project.apiClient
            .getCategoriesModel()
            .then(
              (val) => emit(
                GetCategorySuccessfully(val),
              ),
            )
            .catchError((error) {
          emit(
            GetCategoryError(
              error.toString(),
            ),
          );
        });
      }
    });
  }
}
