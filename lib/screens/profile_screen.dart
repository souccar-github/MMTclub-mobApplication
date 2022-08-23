import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/Localization/Localization.dart';
import 'package:mmt_club/bloc/logoutBloc/logout_bloc.dart';
import 'package:mmt_club/bloc/profileBloc/profile_bloc.dart';
import 'package:mmt_club/screens/login_screen.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/widgets/pull.dart';
import 'package:mmt_club/widgets/user_card.dart';
import '../API/statics.dart';
import '../widgets/custom_circular_slider.dart';
import '../widgets/custom_text.dart';
import '../widgets/logo.dart';
import '../widgets/neum.dart';
import '../widgets/shimmer_category.dart';
import '../widgets/shimmer_news.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorPofileKey =
    GlobalKey<RefreshIndicatorState>();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();
  final LogoutBloc logoutBloc = LogoutBloc();

  @override
  void initState() {
    super.initState();
    profileBloc.add(GetProfileEvent());
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => _refreshIndicatorPofileKey.currentState?.show());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorPofileKey,
      onRefresh: () async {
        //await Future.delayed(const Duration(milliseconds: 10));
        profileBloc.add(GetProfileEvent());
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
              centerTitle: true,
              title: Logo(imagePath: 'assets/images/logommt.png'),
            ),
            actions: [
              BlocListener(
                  bloc: logoutBloc,
                  listener: (context, state) {
                    if (state is LogoutError) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.error,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    } else if (state is LogoutSuccessfully) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: AppColors.basicColor,
                    ),
                    onPressed: () {
                      logoutBloc.add(Logout());
                    },
                  )),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return BlocBuilder(
                  bloc: profileBloc,
                  builder: (context, state) {
                    if (state is GetProfileWaiting) {
                      return const ShimmerCategory();
                    } else if (state is GetProfileError) {
                      return Center(child: PullToRefreesh(
                        onTap: () {
                          profileBloc.add(GetProfileEvent());
                        },
                      ));
                    } else if (state is GetProfileSuccessfully) {
                      return Column(
                        children: [
                          SizedBox(height: 30.h),
                          CustomCircularSlider(profileInfo: state.profileModel),
                          // SizedBox(height: 5.h),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: UserCard(
                          //     username: state.profileModel.username,
                          //     mobile: state.profileModel.username,
                          //   ),
                          // ),
                          SizedBox(height: 30.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                              child: Text(
                                Localization.of(context)
                                        .getTranslatedValue("gifts") +
                                    " :",
                                style: TextStyle(
                                  fontSize: 18.0.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          (state.profileModel.gifts == null ||
                                  state.profileModel.gifts!.isEmpty)
                              ? Container()
                              : CarouselSlider.builder(
                                  options: CarouselOptions(
                                    //autoPlay: true,
                                    viewportFraction: 1.0,
                                    enableInfiniteScroll: false,
                                    //aspectRatio: 2.0,
                                    initialPage: 0,
                                    enlargeCenterPage: true,
                                  ),
                                  itemCount: state.profileModel.gifts!.length,
                                  itemBuilder: (BuildContext context,
                                      int itemIndex, int pageViewIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8.0),
                                      child: Neum(
                                        onPressed: () {},
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: state
                                                      .profileModel
                                                      .gifts![itemIndex]
                                                      .image !=
                                                  null
                                              ? InteractiveViewer(
                                                  clipBehavior: Clip.none,
                                                  minScale: 1,
                                                  maxScale: 4,
                                                  child: Image.network(
                                                    Statics.baseUrl +
                                                        state
                                                            .profileModel
                                                            .gifts![itemIndex]
                                                            .image!,
                                                  ),
                                                )
                                              : const ShimmerNews(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          //to make some space from bottom
                          Container(
                              height: MediaQuery.of(context).size.height / 5)
                        ],
                      );
                    }
                    return Container();
                  });
            },
            childCount: 1,
          ))
        ],
      ),
    );
  }
}
