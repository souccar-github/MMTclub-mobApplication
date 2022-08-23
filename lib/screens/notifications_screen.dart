import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Localization/Localization.dart';
import '../bloc/notificationsBloc/notifications_bloc.dart';
import '../styles/app_colors.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder(
        bloc: notificationsBloc,
        builder: (context, state) {
          if (state is GetNotificationsWaiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetNotificationsSuccessfully) {
            if (state.notifications.isEmpty) {
              return Text(
                Localization.of(context).getTranslatedValue("no_items_found"),
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.basicColor,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(7),
                child: ListView.builder(
                  reverse: true,
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) {
                        //     return;
                        //   }),
                        // );
                      },
                      child: ListTile(
                        title: Text(
                          state.notifications[index].title,
                        ),
                        subtitle: Text(
                          state.notifications[index].body,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
