import 'package:driver_app/features/delivery_history_screen/components/components_export.dart';
import 'package:flutter/material.dart';

class DeliveryHistoryScreen extends StatefulWidget {
  const DeliveryHistoryScreen({super.key});

  static const routeName = 'deliveryHistoryScreen';
  @override
  State<DeliveryHistoryScreen> createState() => _DeliveryHistoryScreenState();
}

class _DeliveryHistoryScreenState extends State<DeliveryHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử chuyến đi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle:Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 20
        ),
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const Column(
              children: [
                SizedBox(height: 16.0),
                DateTimeHistory()
              ],
            ),
          ),
        )
      ),
    );
  }
}