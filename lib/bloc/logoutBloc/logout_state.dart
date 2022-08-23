part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutError extends LogoutInitial {
  final String error;

  LogoutError(this.error);
}

class LogoutSuccessfully extends LogoutInitial {}

class LogoutWaiting extends LogoutInitial {}
