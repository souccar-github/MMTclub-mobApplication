part of 'general_setting_bloc.dart';

abstract class GeneralSettingState extends Equatable {
  const GeneralSettingState();

  @override
  List<Object> get props => [];
}

class GeneralSettingInitial extends GeneralSettingState {}

class GetGeneralSettingError extends GeneralSettingState {
  final String error;

  const GetGeneralSettingError(this.error);
}

class GetGeneralSettingSuccessfully extends GeneralSettingState {
  final GeneralSettingModel generalSettingModel;
  const GetGeneralSettingSuccessfully(this.generalSettingModel);
}

class GetGeneralSettingWaiting extends GeneralSettingState {}
