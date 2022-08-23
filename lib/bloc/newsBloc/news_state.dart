part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class GetAllNewsError extends NewsInitial {
  final String error;

  GetAllNewsError(this.error);
}

class GetAllNewsSuccessfully extends NewsInitial {
  final List<CategoryNewsModel> newsModels;

  GetAllNewsSuccessfully(this.newsModels);
}

class GetAllNewsWaiting extends NewsInitial {}

class GetNewsByIdError extends NewsInitial {
  final String error;

  GetNewsByIdError(this.error);
}

class GetNewsByIdSuccessfully extends NewsInitial {
  final CategoryNewsModel newsModel;

  GetNewsByIdSuccessfully(this.newsModel);
}

class GetNewsByIdWaiting extends NewsInitial {}
