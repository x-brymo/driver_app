import 'package:flutter/material.dart';

class PedingOrderTitle extends StatelessWidget {
  const PedingOrderTitle({
    super.key,
    required this.orderId
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '#$orderId',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 20
          ),
        ),
        Chip(
          label: const Text('Tiền mặt'),
          backgroundColor: Colors.yellow.shade800,
        )
      ],
    );
  }
}