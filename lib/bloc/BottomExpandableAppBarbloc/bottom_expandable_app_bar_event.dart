part of 'bottom_expandable_app_bar_bloc.dart';

abstract class BottomExpandableAppBarEvent extends Equatable {
  const BottomExpandableAppBarEvent();

  @override
  List<Object> get props => [];
}

class CloseQRScreenEvent extends BottomExpandableAppBarEvent {
  final bool isOpen;

  const CloseQRScreenEvent(this.isOpen);
}
