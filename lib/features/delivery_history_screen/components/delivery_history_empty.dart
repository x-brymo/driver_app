import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryHistoryEmpty extends StatelessWidget {
  const DeliveryHistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.faceSadTear,
            size: 50,
            color: Colors.grey
          ),
          const SizedBox(height: 8.0),
          Text(
            'Bạn chưa có chuyến đi vào ngày này',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              color: Colors.grey
            ), 
          ),
        ],
      ),
    );
  }
}