part of 'general_setting_bloc.dart';

abstract class GeneralSettingEvent extends Equatable {
  const GeneralSettingEvent();

  @override
  List<Object> get props => [];
}

class GetGeneralSettingEvent extends GeneralSettingEvent {}
