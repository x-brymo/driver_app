import 'package:driver_app/features/notification_screen/blocs/driver_notification_bloc.dart';
import 'package:driver_app/features/notification_screen/components/components_export.dart';
import 'package:driver_app/models/driver/driver_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = 'notificationScreen';
  @override
  State<NotificationScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationScreen> {
  List<DriverNotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thông báo',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
          child: BlocBuilder<DriverNotificationBloc, DriverNotificationState>(
            builder: (context, state) {
              if(state is GetDriverNotificationsSuccess) {
                List<dynamic> dataResponse = state.apiResponse.data as List<dynamic>;
                notifications = dataResponse.map((notification) => DriverNotificationModel.fromMap(notification)).toList();
              }
              return state is GetDriverNotificationsSuccess
                ? (
                  notifications.isNotEmpty
                    ? NotificationBody(notifications: notifications)
                    : const NotificationEmpty()
                )
                : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green.shade700,
                    ),
                  ),
                )
                ;
            },
          )
        ),
    );
  }
}