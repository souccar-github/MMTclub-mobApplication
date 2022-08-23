part of 'news_bloc.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllNewsEvent extends NewsEvent {
  final int catID;

  GetAllNewsEvent(this.catID);
}

class GetNewsByIdEvent extends NewsEvent {
  final int id;

  GetNewsByIdEvent(this.id);
}
