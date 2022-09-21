import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';
import 'package:mmt_club/bloc/notificationsBloc/notifications_bloc.dart';
import 'package:mmt_club/styles/app_colors.dart';

import '../news/news_screen.dart';
import 'notification_details.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationsModel notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Item(notification: notification),
    );
  }

  getWidgetByType(BuildContext context) {
    switch (notification.distType) {
      case 0:
        {
          final NotificationsBloc notificationsBloc = NotificationsBloc();
          return BlocListener(
            bloc: notificationsBloc,
            listener: (context, state) {
              notificationsBloc
                  .add(SetNotificationIsReadEvent(notification.id));
            },
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsScreen(
                      newsId: notification.distId,
                    ),
                  ),
                );
              },
              child: Item(notification: notification),
            ),
          );
        }

      default:
        return Container();
    }
  }
}

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationsModel notification;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final NotificationsBloc notificationsBloc = NotificationsBloc();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (widget.notification.distType) {
          case 0:
            {
              notificationsBloc
                  .add(SetNotificationIsReadEvent(widget.notification.id));

              setState(() {
                widget.notification.isRead = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsScreen(
                          newsId: widget.notification.distId,
                        )),
              );

              break;
            }

          default:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationDetails(
                    notificationsModel: widget.notification,
                  ),
                ),
              );
              break;
            }
        }
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.textBlack.withOpacity(0.5),
                blurRadius: 10.0,
              ),
            ],
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.h,
                    child: Text(
                      widget.notification.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200.h,
                    child: Text(
                      widget.notification.body,
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 88.w,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Icon(
                  widget.notification.isRead
                      ? FontAwesomeIcons.bell
                      : FontAwesomeIcons.solidBell,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
