part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationsEvent extends NotificationsEvent {}

class SetNotificationIsReadEvent extends NotificationsEvent {
  final int notificationId;

  const SetNotificationIsReadEvent(this.notificationId);
}
