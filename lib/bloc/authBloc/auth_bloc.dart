import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../API/Project/project.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticateEvent>((event, emit) async {
      emit(AuthenticateWaiting());
      await Project.apiClient.register(event.phone).then((_) async {
        emit(AuthenticateSuccessfully());
      }).catchError((e) {
        emit(AuthenticateError(e.toString()));
      });
    });
  }
}
