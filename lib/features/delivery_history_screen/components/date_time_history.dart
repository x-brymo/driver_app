// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/features/delivery_history_screen/blocs/delivery_history_bloc.dart';
import 'package:driver_app/features/delivery_history_screen/components/components_export.dart';
import 'package:driver_app/features/income_statistic_screen/income_statistic_screen.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateTimeHistory extends StatefulWidget {
  const DateTimeHistory({
    super.key,
  });

  @override
  State<DateTimeHistory> createState() => _DateTimeHistoryState();
}

class _DateTimeHistoryState extends State<DateTimeHistory> {
  DateTime currentDate = DateTime.now();
  List<OrderModel> orders = [];
  double totalIncome = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryHistoryBloc, DeliveryHistoryState>(
      builder: (context, state) {
        if (state is GetOrdersListSuccess) {
          List<dynamic> response = state.apiResponse.data as List<dynamic>;
          log(response.toString());
          orders = response.map((order) => OrderModel.fromMap(order)).toList();
          log(orders.toString());

          totalIncome = 0;
          if (orders.isNotEmpty) {
            for (var order in orders) {
              totalIncome += order.shippingCost;
            }
          }
        }

        return Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    DateTime date =
                        DateTime.now().subtract(Duration(days: 30 - index));
                    String dateE = DateFormat('E').format(date);
                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        int id = prefs.getInt('id')!;
                        setState(() {
                          currentDate = date;
                        });
                        context.read<DeliveryHistoryBloc>().add(GetOrdersList(
                            date: DateFormat('yyyy-MM-dd').format(currentDate),
                            id: id.toString(),
                            guard: 'driver'));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color:
                                DateFormat('dd MMM yyyy').format(currentDate) ==
                                        DateFormat('dd MMM yyyy').format(date)
                                    ? Colors.green.shade500
                                    : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateE,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              DateFormat('dd/MMM').format(date),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.motorcycle,
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số chuyến',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            orders.length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState!.pushNamed(IncomeStatisticScreen.routeName);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.coins,
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thu nhập',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              totalIncome.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            orders.isNotEmpty
                ? (state is GetOrdersListPending
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 3 -
                            AppBar().preferredSize.height,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        ),
                      )
                    : DeliveryHistoryData(orders: orders))
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 3 -
                        AppBar().preferredSize.height,
                    child: const DeliveryHistoryEmpty())
          ],
        );
      },
    );
  }
}
