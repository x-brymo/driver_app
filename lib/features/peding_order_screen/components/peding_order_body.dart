// ignore_for_file: must_be_immutable

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../participation_screen/blocs/participation_bloc.dart';

class PedingOrderBody extends StatelessWidget {
  const PedingOrderBody(
      {super.key,
      required this.userName,
      required this.fromAddress,
      required this.toAddress,
      required this.userNote,
      required this.items,
      required this.totalPrice,
      required this.distance,
      required this.order});

  final String userName;
  final String fromAddress;
  final String toAddress;
  final String userNote;
  final Map<String, dynamic> items;
  final double totalPrice;
  final double distance;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18),
                    ),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      ignoreGestures: true,
                    )
                  ],
                )
              ],
            ),
            BlocBuilder<ParticipationBloc, ParticipationState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<ParticipationBloc>()
                        .add(GetMessageList(orderId: order.id.toString()));
                    navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (context) => ParticipationScreen(
                              order: order,
                            )));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade700,
                    child: const Icon(
                      Icons.messenger,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        ListTile(
          leading: Icon(
            Icons.location_on,
            size: 30,
            color: Colors.blue.shade500,
          ),
          title: Text(
            'Nhận hàng',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: Colors.grey.shade400),
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
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: Colors.grey.shade400),
          ),
          subtitle: Text(
            toAddress,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ghi chú:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                ),
                Text(
                  userNote,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16, color: Colors.grey.shade500),
                )
              ],
            ),
            const SizedBox(height: 24.0),
            Container(
              width: MediaQuery.of(context).size.width - 24,
              height: 1,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đơn hàng bao gồm:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                Text(
                  items.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Container(
              width: MediaQuery.of(context).size.width - 24,
              height: 1,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng tiền:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${totalPrice.toStringAsFixed(2)} vnđ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, color: Colors.grey.shade600),
                )
              ],
            ),
            const SizedBox(height: 24.0),
            Container(
              width: MediaQuery.of(context).size.width - 24,
              height: 1,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Khoảng cách:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                Text(
                  '${distance.toStringAsFixed(2)} vnđ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, color: Colors.grey.shade600),
                )
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chỉ đường:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    Navigator.pushNamedAndRemoveUntil(context,
                        HomeScreen.routeName, (route) => route is HomeScreen);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade700,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
