import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/widgets/refresh.dart';

import '../../Localization/localization.dart';
import '../../bloc/notificationsBloc/notifications_bloc.dart';
import '../../styles/app_colors.dart';
import '../../widgets/notification/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationsBloc notificationsBloc = NotificationsBloc();
  @override
  void initState() {
    super.initState();

    notificationsBloc.add(GetNotificationsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    notificationsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("notifactions"),
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: notificationsBloc,
        builder: (context, state) {
          if (state is GetNotificationsWaiting) {
            return Center(
              child: SpinKitPouringHourGlassRefined(
                color: AppColors.basicColor.withOpacity(0.7),
              ),
            );
          } else if (state is GetNotificationsSuccessfully) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Text(
                  Localization.of(context)
                      .getTranslatedValue("no_notifactions"),
                  style: AppTextStyle.customButtonTextTheme(
                      context, AppColors.basicColor),
                ),
              );
            } else {
              int length = state.notifications.length;
              return Padding(
                padding: const EdgeInsets.all(7),
                child: ListView.builder(
                  primary: false,
                  itemCount: length,
                  itemBuilder: (context, index) {
                    NotificationsModel notification =
                        state.notifications[length - 1 - index];
                    return NotificationCard(notification: notification);
                  },
                ),
              );
            }
          } else {
            return Center(
              child: TapToRefreesh(onTap: () {
                notificationsBloc.add(GetNotificationsEvent());
              }),
            );
          }
        },
      ),
    );
  }
}
