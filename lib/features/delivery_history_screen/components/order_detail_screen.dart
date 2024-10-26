import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String fromAddress = '';
  String toAddress = '';
  late OrderModel order;

  void prepareLocation() async {
    LatLng from = LatLng(order.fromAddress.lat, order.fromAddress.lng);
    LatLng to = LatLng(order.toAddress.lat, order.toAddress.lng);

    Either<Failure, VietmapReverseModel> response = await Vietmap.reverse(from);
    response.fold((l) => null, (r) {
      setState(() {
        fromAddress = r.address.toString();
      });
    });

    response = await Vietmap.reverse(to);
    response.fold((l) => null, (r) {
      setState(() {
        toAddress = r.address.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      order = widget.order;
    });
    prepareLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết đơn hàng',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${order.id}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20),
                ),
                Chip(
                  label: const Text('Tiền mặt'),
                  backgroundColor: Colors.yellow.shade800,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: CircleAvatar(
                            radius: 30,
                            child: Image.asset('assets/images/logo.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              order.user.name,
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          order.userNote,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16, color: Colors.grey.shade500),
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          order.items.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${order.shippingCost.toStringAsFixed(2)} vnđ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 18, color: Colors.grey.shade600),
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          '${order.distance.toStringAsFixed(2)} km',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 18, color: Colors.grey.shade600),
                        )
                      ],
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
