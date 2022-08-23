part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class SendComplaintEvent extends ComplaintEvent {
  final ComplaintModel complaintModel;

  const SendComplaintEvent(this.complaintModel);
}
