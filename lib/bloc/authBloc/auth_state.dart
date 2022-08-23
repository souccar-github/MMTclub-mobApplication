part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticateError extends AuthInitial {
  final String error;

  AuthenticateError(this.error);
}

class AuthenticateSuccessfully extends AuthInitial {}

class AuthenticateWaiting extends AuthInitial {}
