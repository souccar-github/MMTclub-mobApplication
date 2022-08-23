part of 'qrcode_bloc.dart';

abstract class QrcodeState extends Equatable {
  const QrcodeState();

  @override
  List<Object> get props => [];
}

class QrcodeInitial extends QrcodeState {}

class ReadQrcodeError extends QrcodeInitial {
  final ErrorModel error;

  ReadQrcodeError(this.error);
}

class ReadQrcodeSuccessfully extends QrcodeInitial {}

class ReadQrcodeWaiting extends QrcodeInitial {}
