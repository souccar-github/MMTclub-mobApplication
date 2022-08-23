import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mmt_club/API/Project/project.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is GetAllNewsEvent) {
        emit(GetAllNewsWaiting());

        await Project.apiClient.getAllNews(event.catID).then((news) {
          emit(GetAllNewsSuccessfully(news));
        }).catchError((error) {
          emit(GetAllNewsError(error.toString()));
        });
      } else if (event is GetNewsByIdEvent) {
        emit(GetNewsByIdWaiting());

        await Project.apiClient.getNewsById(event.id).then((news) {
          emit(GetNewsByIdSuccessfully(news));
        }).catchError((error) {
          emit(GetNewsByIdError(error.toString()));
        });
      }
    });
  }
}
