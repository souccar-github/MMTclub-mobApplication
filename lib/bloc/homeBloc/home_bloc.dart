import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/home_model.dart';

import '../../API/Project/project.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeEvent) {
        emit(GetHomeWaiting());
        await Project.apiClient.getHomeModel().then((homeModel) {
          emit(GetHomeSuccessfully(homeModel));
        }).catchError((error) {
          emit(GetHomeError(error.toString()));
        });
      }
    });
  }
}
