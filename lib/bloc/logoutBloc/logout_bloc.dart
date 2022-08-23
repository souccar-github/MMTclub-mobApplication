import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../API/Project/project.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<Logout>((event, emit) async {
      emit(LogoutWaiting());
      await Project.apiClient.logout().then((_) async {
        emit(LogoutSuccessfully());
      }).catchError((e) {
        LogoutError(e.toString());
      });
    });
  }
}
