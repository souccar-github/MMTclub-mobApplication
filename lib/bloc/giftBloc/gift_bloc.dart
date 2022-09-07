import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../API/Project/Project.dart';

part 'gift_event.dart';
part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  GiftBloc() : super(GiftInitial()) {
    on<GiftEvent>((event, emit) async {
      if (event is GetYourGiftEvent) {
        emit(GetYourGiftWaiting());
        await Project.apiClient.getYourGift(event.giftId).then((_) {
          emit(GetYourGiftSuccessfully());
        }).catchError((error) {
          emit(GetYourGiftError(error.toString()));
        });
      }
    });
  }
}
