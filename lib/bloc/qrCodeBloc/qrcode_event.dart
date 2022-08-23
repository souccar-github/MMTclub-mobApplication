part of 'qrcode_bloc.dart';

abstract class QrcodeEvent extends Equatable {
  const QrcodeEvent();

  @override
  List<Object> get props => [];
}

class SendQrcodeEvent extends QrcodeEvent {
  final String code;

  const SendQrcodeEvent(this.code);
}
