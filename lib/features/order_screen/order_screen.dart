// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/constants/app_const.dart';
import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/features/order_screen/blocs/order_bloc.dart';
import 'package:driver_app/features/order_screen/components/components_export.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const routeName = 'orderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderModel order;
  late String fromAddress;
  late String toAddress;

  late Future<dynamic> futureData;

  @override
  void initState() {
    futureData = prepareData();
    super.initState();
  }

  Future<dynamic> prepareData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Vietmap.getInstance(MAP_KEY);

    if (prefs.getString('order') != null) {
      setState(() {
        order = OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
      });
      log('ORDER: $order');

      LatLng from = LatLng(order.fromAddress.lat, order.fromAddress.lng);
      LatLng to = LatLng(order.toAddress.lat, order.toAddress.lng);

      Either<Failure, VietmapReverseModel> response =
          await Vietmap.reverse(from);
      response.fold((l) => null, (r) {
        setState(() {
          fromAddress = r.name.toString();
        });
      });

      response = await Vietmap.reverse(to);
      response.fold((l) => null, (r) {
        setState(() {
          toAddress = r.name.toString();
        });
      });

      return order;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.green.shade700,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return BlocListener<OrderBloc, OrderState>(
                  listener: (context, state) async {
                    if (state is RefuseOrderPeding) {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green.shade800,
                                ),
                              ));
                    } else if (state is RefuseOrderSuccess) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('order');

                      navigatorKey.currentState!.pop();
                    }else if(state is RefuseOrderFailed) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('order');
                    }
                  },
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            OrderTitle(order: order),
                            const SizedBox(height: 12.0),
                            OrderBody(
                                fromAddress: fromAddress, toAddress: toAddress),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonCustom(
                                  width: MediaQuery.of(context).size.width *
                                      1.5 /
                                      4,
                                  height: 40.0,
                                  color: Colors.red.shade900,
                                  text: 'Từ chối',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                  radius: 30.0,
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    context.read<OrderBloc>().add(RefuseOrder(
                                        id: order.id.toString(),
                                        token: prefs.getString('token')!,
                                        orderStatusId: "7"));
                                  },
                                ),
                                ButtonCustom(
                                  width: MediaQuery.of(context).size.width *
                                      1.5 /
                                      4,
                                  height: 40.0,
                                  color: Colors.green.shade900,
                                  text: state is OrderPeding
                                      ? 'Loading...'
                                      : 'Nhận đơn',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                  radius: 30.0,
                                  onTap: state is OrderPeding
                                      ? () {}
                                      : () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          DateTime now = DateTime.now();

                                          context.read<OrderBloc>().add(
                                              ReceiveOrder(
                                                  driverId: prefs.getInt('id')!,
                                                  orderStatusId: 2,
                                                  driverAcceptAt:
                                                      now.toIso8601String()));
                                          Navigator.pushReplacementNamed(
                                              context,
                                              PedingOrderScreen.routeName);
                                        },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
