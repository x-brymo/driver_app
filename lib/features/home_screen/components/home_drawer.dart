// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/features/home_screen/blocs/blocs_export.dart';
import 'package:driver_app/features/income_statistic_screen/blocs/income_statistic_bloc.dart';
import 'package:driver_app/features/notification_screen/blocs/driver_notification_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.userName,
    required this.reviewRate,
    required this.imageFile,
  }) : super(key: key);

  final String userName;
  final double reviewRate;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(color: Colors.green.shade700),
                child: Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      imageFile != null
                          ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  image: imageFile != null
                                      ? DecorationImage(
                                          image:
                                              FileImage(imageFile ?? File('')),
                                          fit: BoxFit.cover)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100))),
                            )
                          : ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/user.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                userName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 22),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                Chip(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    label: Text(
                                      reviewRate.toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      HomeScreen.routeName, (route) => route is HomeScreen);
                },
                title: const Text('Trang chủ'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.delivery_dining,
                ),
                onTap: () async {
                  Navigator.pushNamed(context, PedingOrderScreen.routeName);
                },
                title: const Text('Đơn đang giao'),
              ),
              BlocBuilder<IncomeStatisticBloc, IncomeStatisticState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(
                      Icons.bar_chart,
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      context.read<IncomeStatisticBloc>().add(GetIncome(
                          type: 'month', id: prefs.getInt('id')!.toString()));

                      Navigator.pushNamed(
                          context, IncomeStatisticScreen.routeName);
                    },
                    title: const Text('Thống kê'),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.history,
                ),
                onTap: () {
                  Navigator.pushNamed(context, DeliveryHistoryScreen.routeName);
                },
                title: const Text('Lịch sử chuyến đi'),
              ),
              BlocBuilder<DriverNotificationBloc, DriverNotificationState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(
                      Icons.notifications,
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      context.read<DriverNotificationBloc>().add(
                          GetDriverNotifications(
                              guard: 'driver',
                              id: prefs.getInt('id')!.toString()));

                      Navigator.pushNamed(
                          context, NotificationScreen.routeName);
                    },
                    title: const Text('Thông báo'),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                },
                title: const Text('Thông tin cá nhân'),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      final ul = {'lat': "0", 'lng': "0"};
                      context.read<HomeBloc>().add(DriverActive(
                          currentLocation: jsonEncode(ul), status: 0));

                      context.read<DrawerBloc>().add(
                          Logout(token: prefs.getString('token').toString()));
                    },
                    title: const Text('Đăng xuất'),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
