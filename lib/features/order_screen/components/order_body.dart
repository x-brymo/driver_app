import 'package:flutter/material.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({
    super.key,
    required this.fromAddress,
    required this.toAddress,
  });

  final String fromAddress;
  final String toAddress;

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
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on,
              size: 30,
              color: Colors.blue.shade500,
            ),
            title: Text(
              'Nhận hàng',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                color: Colors.grey.shade400
              ),  
            ),
            subtitle: Text(
              fromAddress,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ), 
            ),
          ),
          const SizedBox(height: 12.0),

          ListTile(
            leading: const Icon(
              Icons.location_on,
              size: 30,
              color: Colors.red,
            ),
            title: Text(
              'Giao hàng',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                color: Colors.grey.shade400
              ),  
            ),
            subtitle: Text(
              toAddress,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ), 
            ),
          )
        ],
      ),
    );
  }
}