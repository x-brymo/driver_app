import 'package:driver_app/features/delivery_history_screen/components/components_export.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DeliveryHistoryData extends StatelessWidget {
  const DeliveryHistoryData({
    super.key,
    required this.orders,
  });

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          OrderModel order = orders[index];
          DateTime createdAt = DateTime.parse(order.createdAt);

          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd/MMM/yyyy hh:mm').format(createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width - 24,
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Khoảng cách:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text('${order.distance.toStringAsFixed(2)} km')
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      FontAwesomeIcons.dollarSign,
                    ),
                    Text('${order.shippingCost.toStringAsFixed(2)} vnđ')
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width - 24,
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderStatus.id == 5
                          ? 'Hoàn thành'
                          : 'Chưa hoàn thành',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: order.orderStatus.id == 5
                              ? Colors.green
                              : Colors.red),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailScreen(order: order)));
                      },
                      child: const Icon(
                        Icons.arrow_right_sharp,
                        size: 35,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
