part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileError extends ProfileInitial {
  final String error;

  GetProfileError(this.error);
}

class GetProfileSuccessfully extends ProfileInitial {
  final ProfileModel profileModel;

  GetProfileSuccessfully(this.profileModel);
}

class GetProfileWaiting extends ProfileInitial {}
