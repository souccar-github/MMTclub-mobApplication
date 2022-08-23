import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/complaint_model.dart';

import '../../API/Project/project.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitial()) {
    on<ComplaintEvent>((event, emit) async {
      if (event is SendComplaintEvent) {
        emit(SendComplaintWaiting());
        await Project.apiClient.complaint(event.complaintModel).then((_) {
          emit(SendComplaintSuccessfully());
        }).catchError((error) {
          emit(SendComplaintError(error.toString()));
        });
      }
    });
  }
}
