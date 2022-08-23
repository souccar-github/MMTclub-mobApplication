import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/profile_model.dart';

import '../../API/Project/project.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        emit(GetProfileWaiting());
        await Project.apiClient.getProfileModel().then((model) {
          emit(GetProfileSuccessfully(model));
        }).catchError((error) {
          emit(GetProfileError(error.toString()));
        });
      }
    });
  }
}
