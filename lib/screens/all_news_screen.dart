import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_club/bloc/newsBloc/news_bloc.dart';
import '../Localization/Localization.dart';
import '../styles/app_colors.dart';
import '../widgets/news_card.dart';
import '../widgets/shimmer_list.dart';

class AllNeswScreen extends StatefulWidget {
  final int catId;
  const AllNeswScreen({Key? key, required this.catId}) : super(key: key);

  @override
  State<AllNeswScreen> createState() => _AllNeswScreenState();
}

class _AllNeswScreenState extends State<AllNeswScreen> {
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


// class _NewsLayout extends StatelessWidget {
//   final CategoryNewsModel categoryNewsModel;
//   const _NewsLayout({Key? key, required this.categoryNewsModel})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         height: 100.h,
//         child: Card(
//           elevation: 9,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 150.h,
//                 width: 100.w,
//                 color: Colors.white,
//                 child: categoryNewsModel.imagePath != null
//                     ? Image.network(
//                         categoryNewsModel.imagePath!,
//                         fit: BoxFit.contain,
//                       )
//                     : null,
//               ),
//               Expanded(
//                 child: ListTile(
//                   dense: false,
//                   title: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       categoryNewsModel.name ?? "",
//                       style: TextStyle(
//                           //fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: AppColors.basicColor),
//                     ),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 5.0),
//                     child: Text(
//                       categoryNewsModel.description,
//                       style: const TextStyle(fontSize: 14),
//                       maxLines: 3,
//                     ),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios,
//                     color: AppColors.basicColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
