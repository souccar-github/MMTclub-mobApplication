import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/giftBloc/gift_bloc.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/widgets/my_toast.dart';

import '../../API/statics.dart';
import '../../Localization/localization.dart';
import '../../Models/Project/gifts_model.dart';
import '../../styles/app_colors.dart';
import '../../widgets/custom_button.dart';

class GiftScreen extends StatelessWidget {
  final GiftsModel gift;
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  GiftScreen({Key? key, required this.gift, this.refreshKey}) : super(key: key);
  final GiftBloc giftBloc = GiftBloc();

  addEventGetYourGift(bool isActive, BuildContext context) {
    if (isActive) {
      giftBloc.add(GetYourGiftEvent(gift.id));
    } else {
      MyToast.show(
          context: context,
          text: Localization.of(context)
              .getTranslatedValue("sorry_there_is_no_gift_av"),
          toastState: ToastState.ERROR);
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
          Localization.of(context).getTranslatedValue("gift_details"),
          style: AppTextStyle.appBarTextTheme(context),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: gift.image == null
                      ? Container()
                      : AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            Statics.baseUrl + gift.image!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                ),
                if (gift.isActive)
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: BlocBuilder(
                      bloc: giftBloc,
                      builder: (context, state) {
                        if (state is GetYourGiftWaiting) {
                          return CustomButton(
                            child: CircularProgressIndicator(
                              color: AppColors.textBlack.withOpacity(0.7),
                            ),
                          );
                        } else if (state is GetYourGiftSuccessfully) {
                          MyToast.show(
                              context: context,
                              text: Localization.of(context)
                                  .getTranslatedValue("request_Gift"),
                              toastState: ToastState.SUCCESS);
                          WidgetsBinding.instance!.addPostFrameCallback(
                              (_) => refreshKey!.currentState?.show());
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.pop(context);
                          });

                          return Container();
                        } else if (state is GetYourGiftError) {
                          MyToast.show(
                              context: context,
                              text: state.error,
                              toastState: ToastState.ERROR);
                          return CustomButton(
                            text: Localization.of(context)
                                .getTranslatedValue("Get_your_Gift"),
                            onPressed: () {
                              addEventGetYourGift(gift.isActive, context);
                            },
                            icon: FontAwesomeIcons.cartPlus,
                            size: 20.h,
                          );
                        } else {
                          return CustomButton(
                            text: gift.isActive
                                ? Localization.of(context)
                                    .getTranslatedValue("Get_your_Gift")
                                : "",
                            onPressed: () {
                              addEventGetYourGift(gift.isActive, context);
                            },
                            icon: gift.isActive
                                ? FontAwesomeIcons.cartPlus
                                : FontAwesomeIcons.lock,
                            size: 20.h,
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 4.0),
              child: Text(
                gift.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 4.0),
              child: Text(
                gift.description ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
