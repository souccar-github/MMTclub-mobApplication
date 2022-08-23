import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mmt_club/Models/Project/error.dart';

import '../../API/Project/project.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  QrcodeBloc() : super(QrcodeInitial()) {
    on<SendQrcodeEvent>((event, emit) async {
      emit(ReadQrcodeWaiting());
      var data = await Project.apiClient.readQrcode(event.code);
      if (data is String) {
        if (data == "200") {
          emit(ReadQrcodeSuccessfully());
        } else {
          ErrorModel errorModel = ErrorModel(0, data);
          emit(ReadQrcodeError(errorModel));
        }
      } else if (data is ErrorModel) {
        emit(ReadQrcodeError(data));
      }
    });
  }
}
