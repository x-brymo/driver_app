// ignore_for_file: non_constant_identifier_names

import 'package:driver_app/models/driver/driver_notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({
    super.key,
    required this.notifications,
  });

  final List<DriverNotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: notifications.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: NotificationItem
      )
    );
  }

  Widget? NotificationItem(context, index) {
    DriverNotificationModel notification = notifications[index];
    DateTime createdAt = DateTime.parse(notification.createdAt);
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(2, 2),
            blurRadius: 2
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd/MMM/yyyy').format(createdAt) == DateFormat('dd/MMM/yyyy').format(DateTime.now())
            ? 'Hôm nay'
            : DateFormat('dd/MMM/yyyy').format(createdAt),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 16
            ),
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30)
              ),
              child: CircleAvatar(
                radius: 30,
                child: Image.asset(
                  'assets/images/logo.png', 
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            title: Text(notification.title),
            subtitle: Text(notification.body),
            trailing: const Icon(
              FontAwesomeIcons.bell,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
