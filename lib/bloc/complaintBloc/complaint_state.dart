part of 'complaint_bloc.dart';

abstract class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}

class ComplaintInitial extends ComplaintState {}

class SendComplaintError extends ComplaintInitial {
  final String error;

  SendComplaintError(this.error);
}

class SendComplaintSuccessfully extends ComplaintInitial {
  SendComplaintSuccessfully();
}

class SendComplaintWaiting extends ComplaintInitial {}
