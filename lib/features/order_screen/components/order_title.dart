import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';

class OrderTitle extends StatelessWidget {
  const OrderTitle({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: CircleAvatar(
              radius: 30,
              child: Image.asset('assets/images/logo.png',
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  order.user.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20
                  ),
                ),
              ),
              Chip(
                backgroundColor: Colors.yellow.shade700,
                label: const Text( 'Tiền mặt' ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${order.shippingCost.toStringAsFixed(2)} vnđ',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Colors.green.shade700
                ),
              ),
              Text(
                '${order.distance.toStringAsFixed(2)} km',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  color: Colors.grey.shade400
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}