part of 'gift_bloc.dart';

abstract class GiftState extends Equatable {
  const GiftState();

  @override
  List<Object> get props => [];
}

class GiftInitial extends GiftState {}

class GetYourGiftError extends GiftInitial {
  final String error;

  GetYourGiftError(this.error);
}

class GetYourGiftSuccessfully extends GiftInitial {}

class GetYourGiftWaiting extends GiftInitial {}
