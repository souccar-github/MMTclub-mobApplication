part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetHomeError extends HomeInitial {
  final String error;

  GetHomeError(this.error);
}

class GetHomeSuccessfully extends HomeInitial {
  final HomeModel homeModel;

  GetHomeSuccessfully(this.homeModel);
}

class GetHomeWaiting extends HomeInitial {}
