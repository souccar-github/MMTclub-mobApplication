import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';
import 'package:mmt_club/bloc/notificationsBloc/notifications_bloc.dart';
import 'package:mmt_club/widgets/news/news_details.dart';

import 'notification_details.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
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
                    builder: (context) => NewsDetails(
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
                    builder: (context) => NewsDetails(
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
                  builder: (context) => NotificatioDetails(
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
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.notification.body,
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 88.w,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Icon(widget.notification.isRead
                    ? FontAwesomeIcons.bell
                    : FontAwesomeIcons.solidBell),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
