part of 'bottom_expandable_app_bar_bloc.dart';

abstract class BottomExpandableAppBarState extends Equatable {
  const BottomExpandableAppBarState();

  @override
  List<Object> get props => [];
}

class BottomExpandableAppBarInitial extends BottomExpandableAppBarState {}

class CloseQRScreen extends BottomExpandableAppBarInitial {
  final bool isOpen;

  CloseQRScreen(this.isOpen);
}
