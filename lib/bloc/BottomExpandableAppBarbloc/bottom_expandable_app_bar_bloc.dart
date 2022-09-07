import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_expandable_app_bar_event.dart';
part 'bottom_expandable_app_bar_state.dart';

class BottomExpandableAppBarBloc
    extends Bloc<BottomExpandableAppBarEvent, BottomExpandableAppBarState> {
  BottomExpandableAppBarBloc() : super(BottomExpandableAppBarInitial()) {
    on<BottomExpandableAppBarEvent>((event, emit) {
      if (event is CloseQRScreenEvent) {
        emit(CloseQRScreen(event.isOpen));
      }
    });
  }
}
