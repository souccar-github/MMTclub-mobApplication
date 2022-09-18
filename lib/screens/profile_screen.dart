import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/bloc/logoutBloc/logout_bloc.dart';
import 'package:mmt_club/bloc/profileBloc/profile_bloc.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/screens/login_screen.dart';
import 'package:mmt_club/widgets/hour_glass.dart';
import 'package:mmt_club/widgets/my_slider.dart';
import 'package:mmt_club/styles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mmt_club/widgets/refresh.dart';
import '../widgets/custom_circular_slider.dart';
import '../widgets/logo.dart';
import '../widgets/my_toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();
  final LogoutBloc logoutBloc = LogoutBloc();
  late GlobalKey<RefreshIndicatorState> _refreshIndicatorPofileKey;

  @override
  void initState() {
    super.initState();
    //profileBloc.add(GetProfileEvent());
    _refreshIndicatorPofileKey = GlobalKey<RefreshIndicatorState>();
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => _refreshIndicatorPofileKey.currentState?.show());
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc.close();
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
                      MyToast.show(
                          context: context,
                          text: state.error.toString(),
                          toastState: ToastState.ERROR);
                    } else if (state is LogoutSuccessfully) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  child: TextButton(
                    child: Row(
                      children: [
                        Text(Localization.of(context)
                            .getTranslatedValue("signOut")),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: AppColors.basicColor,
                        ),
                      ],
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
                      return const HourGlass();
                    } else if (state is GetProfileError) {
                      return Center(child: TapToRefreesh(
                        onTap: () {
                          profileBloc.add(GetProfileEvent());
                        },
                      ));
                    } else if (state is GetProfileSuccessfully) {
                      return Column(
                        children: [
                          SizedBox(height: 30.h),
                          CustomCircularSlider(profileInfo: state.profileModel),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                                child: Text(
                                  Localization.of(context)
                                          .getTranslatedValue("gifts") +
                                      " :",
                                  style: AppTextStyle.titeTextTheme(context),
                                ),
                              ),
                            ],
                          ),
                          if (state.profileModel.level != null &&
                              state.profileModel.level!.gifts != null)
                            MySlider(
                                gifts: state.profileModel.level!.gifts!,
                                isGift: true,
                                refreshKey: _refreshIndicatorPofileKey),

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
