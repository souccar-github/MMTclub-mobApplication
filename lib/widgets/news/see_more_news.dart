import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_club/bloc/newsBloc/news_bloc.dart';

import '../../Localization/localization.dart';
import '../../styles/app_colors.dart';
import 'news_card.dart';
import '../shimmer_list.dart';

class SeeMoreNews extends StatefulWidget {
  final int catId;
  const SeeMoreNews({Key? key, required this.catId}) : super(key: key);

  @override
  State<SeeMoreNews> createState() => _SeeMoreNewsState();
}

class _SeeMoreNewsState extends State<SeeMoreNews> {
  final NewsBloc newsBloc = NewsBloc();
  @override
  void initState() {
    super.initState();
    newsBloc.add(GetAllNewsEvent(widget.catId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("allNews"),
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textBlack,
          ),
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
      body: BlocBuilder(
        bloc: newsBloc,
        builder: (context, state) {
          if (state is GetAllNewsWaiting) {
            return const ShimmerList();
          } else if (state is GetAllNewsSuccessfully) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.newsModels.length,
              itemBuilder: (BuildContext context, int index) {
                return NewsCard(
                  news: state.newsModels[index],
                );
              },
            );
          } else if (state is GetAllNewsError) {
            SnackBar(
              content: Text(
                state.error.toString(),
                style: TextStyle(color: AppColors.textWhite),
              ),
              backgroundColor: AppColors.error,
            );
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
