part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsError extends NotificationsInitial {
  final String error;

  GetNotificationsError(this.error);
}

class GetNotificationsSuccessfully extends NotificationsInitial {
  final List<NotificationsModel> notifications;

  GetNotificationsSuccessfully(this.notifications);
}

class GetNotificationsWaiting extends NotificationsInitial {}

class IsReadNotificationsError extends NotificationsInitial {
  final String error;

  IsReadNotificationsError(this.error);
}

class IsReadNotificationsSuccessfully extends NotificationsInitial {}

class IsReadNotificationsWaiting extends NotificationsInitial {}
