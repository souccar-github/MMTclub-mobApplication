import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/general_settings_model.dart';

import '../../API/Project/project.dart';

part 'general_setting_event.dart';
part 'general_setting_state.dart';

class GeneralSettingBloc
    extends Bloc<GeneralSettingEvent, GeneralSettingState> {
  GeneralSettingBloc() : super(GeneralSettingInitial()) {
    on<GeneralSettingEvent>((event, emit) async {
      if (event is GetGeneralSettingEvent) {
        emit(GetGeneralSettingWaiting());
        await Project.apiClient.getGeneralSettingModel().then((v) {
          emit(GetGeneralSettingSuccessfully(v!));
        }).catchError((error) {
          emit(GetGeneralSettingError(error.toString()));
        });
      }
    });
  }
}
