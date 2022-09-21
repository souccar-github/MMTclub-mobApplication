import 'package:flutter/material.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';

import '../../Localization/localization.dart';
import '../../styles/app_colors.dart';

class NotificationDetails extends StatelessWidget {
  final NotificationsModel notificationsModel;
  const NotificationDetails({Key? key, required this.notificationsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("notifaction_details"),
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
      body: Card(
        elevation: 25.0,
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                child: Text(
                  notificationsModel.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(notificationsModel.body,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
