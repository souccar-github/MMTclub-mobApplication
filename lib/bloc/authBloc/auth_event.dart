part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateEvent extends AuthEvent {
  final String phone;

  const AuthenticateEvent(this.phone);
}
