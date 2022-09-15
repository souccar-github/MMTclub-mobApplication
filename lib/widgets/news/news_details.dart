import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
import 'package:mmt_club/constants.dart';

import '../../API/statics.dart';
import '../../Localization/localization.dart';
import '../../bloc/newsBloc/news_bloc.dart';
import '../../styles/app_colors.dart';

class NewsDetails extends StatefulWidget {
  final CategoryNewsModel? news;
  final int? newsId;
  const NewsDetails({Key? key, this.news, this.newsId}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final NewsBloc newsBloc = NewsBloc();
  @override
  void initState() {
    super.initState();
    if (widget.newsId != null) {
      newsBloc.add(GetNewsByIdEvent(widget.newsId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("news_details"),
          style: CustomTextStyle.appBarTextTheme(context),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlack,
            )),
      ),
      body: widget.newsId == null
          ? Details(news: widget.news!)
          : BlocBuilder(
              bloc: newsBloc,
              builder: (context, state) {
                if (state is GetNewsByIdWaiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetNewsByIdSuccessfully) {
                  return Details(news: state.newsModel);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.news,
  }) : super(key: key);

  final CategoryNewsModel news;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          child: news.image == null
              ? Container()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      Statics.baseUrl + news.image!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 4.0),
          child: Text(
            news.title ?? "",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 4.0),
          child: Text(
            news.description ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
