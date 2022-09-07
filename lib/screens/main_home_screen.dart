import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mmt_club/Models/Project/home_model.dart';
import 'package:mmt_club/bloc/homeBloc/home_bloc.dart';
import 'package:mmt_club/widgets/refresh.dart';
import '../widgets/category.dart';
import '../widgets/custom_circular_slider.dart';
import '../widgets/hour_glass.dart';
import '../widgets/logo.dart';
import '../widgets/slogan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  late GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  @override
  void initState() {
    super.initState();
    //homeBloc.add(GetHomeEvent());
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());
  }

  @override
  void dispose() {
    super.dispose();
    homeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        //await Future.delayed(const Duration(milliseconds: 10));
        homeBloc.add(GetHomeEvent());
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            expandedHeight: 200.h,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              expandedTitleScale: 1.5,
              //titlePadding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              centerTitle: true,
              title: Logo(imagePath: 'assets/images/logommt.png'),
            ),
          ),
          SliverBody(
            homeBloc: homeBloc,
          ),
        ],
      ),
    );
  }
}

class SliverBody extends StatelessWidget {
  final HomeBloc homeBloc;

  const SliverBody({
    Key? key,
    required this.homeBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            const Center(child: Slogan()),
            BlocBuilder(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is GetHomeWaiting) {
                  return const HourGlass();
                } else if (state is GetHomeError) {
                  return TapToRefreesh(
                    onTap: () {
                      homeBloc.add(GetHomeEvent());
                    },
                  );
                } else if (state is GetHomeSuccessfully) {
                  return Column(
                    children: [
                      CustomCircularSlider(homeInfo: state.homeModel),
                      Categories(
                        homeModel: state.homeModel,
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ],
        );
      }, childCount: 1),
    );
  }
}

class Categories extends StatelessWidget {
  List<Widget> getCategories(categories, size) {
    List<Widget> gt = [];
    for (var i = 0; i < categories.length; i++) {
      gt.add(Category(categoryModel: categories[i]));
    }
    //to make some space from bottom
    gt.add(Container(height: size.height / 5));

    return gt;
  }

  final HomeModel? homeModel;

  const Categories({
    Key? key,
    required this.homeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          getCategories(homeModel!.categories!, MediaQuery.of(context).size),
    );
  }
}
