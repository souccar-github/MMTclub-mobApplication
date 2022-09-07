import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';

import '../../API/Project/Project.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) async {
      if (event is GetNotificationsEvent) {
        emit(GetNotificationsWaiting());
        await Project.apiClient
            .notifications()
            .then(
              (val) => emit(
                GetNotificationsSuccessfully(val),
              ),
            )
            .catchError((error) {
          emit(
            GetNotificationsError(
              error.toString(),
            ),
          );
        });
      } else if (event is SetNotificationIsReadEvent) {
        Project.apiClient.setNotificationIsRead(event.notificationId);
      }
    });
  }
}
