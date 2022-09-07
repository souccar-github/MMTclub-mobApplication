part of 'gift_bloc.dart';

abstract class GiftEvent extends Equatable {
  const GiftEvent();

  @override
  List<Object> get props => [];
}

class GetYourGiftEvent extends GiftEvent {
  final int giftId;

  const GetYourGiftEvent(this.giftId);
}
