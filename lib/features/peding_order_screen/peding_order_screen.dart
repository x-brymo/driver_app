// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/features/peding_order_screen/blocs/peding_order_bloc.dart';
import 'package:driver_app/features/peding_order_screen/components/components_export.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class PedingOrderScreen extends StatefulWidget {
  const PedingOrderScreen({
    super.key,
  });

  static const routeName = 'PedingOrderScreen';
  @override
  State<PedingOrderScreen> createState() => _PedingOrderScreenState();
}

class _PedingOrderScreenState extends State<PedingOrderScreen> {
  double sliderValue = 0;

  OrderModel? order;
  late Future<dynamic> fetchData;
  String fromAddress = '';
  String toAddress = '';
  String orderStatus = 'Đã đến điểm lấy';

  @override
  void initState() {
    super.initState();
    fetchData = prepareOrder();
  }

  Future<dynamic> prepareOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('order') != null) {
      setState(() {
        order = OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
      });

      LatLng from = LatLng(order!.fromAddress.lat, order!.fromAddress.lng);
      LatLng to = LatLng(order!.toAddress.lat, order!.toAddress.lng);

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
    }

    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: order == null
            ? const PedingOrderEmpty()
            : FutureBuilder(
                future: fetchData,
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
                    return BlocListener<PedingOrderBloc, PedingOrderState>(
                      listener: (context, state) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (state is PedingOrderSuccess) {
                          order = OrderModel.fromMap(state.apiResponse.data);
                          prefs.setString(
                              'order', jsonEncode(state.apiResponse.data));

                          log(order.toString());
                        }
                      },
                      child: BlocBuilder<PedingOrderBloc, PedingOrderState>(
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PedingOrderTitle(
                                  orderId: order!.id.toString(),
                                ),
                                PedingOrderBody(
                                  userName: order!.user.name,
                                  fromAddress: fromAddress,
                                  toAddress: toAddress,
                                  items: order!.items,
                                  totalPrice: order!.shippingCost,
                                  userNote: order!.userNote,
                                  distance: order!.distance,
                                  order: order!,
                                ),
                                const SizedBox(height: 24.0),
                                Stack(
                                  children: [
                                    SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.amber,
                                          inactiveTrackColor:
                                              Colors.grey.shade400,
                                          trackHeight: 50.0,
                                          trackShape:
                                              const RectangularSliderTrackShape(),
                                          thumbShape:
                                              SliderComponentShape.noThumb,
                                        ),
                                        child: Slider(
                                            onChangeEnd: (value) async {
                                              if (value == 10.0) {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                if (order!.orderStatus.id ==
                                                    2) {
                                                  context
                                                      .read<PedingOrderBloc>()
                                                      .add(
                                                          const UpdateStatusOrder(
                                                              orderStatusId:
                                                                  "3"));

                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          PedingOrderScreen
                                                              .routeName);
                                                } else if (order!
                                                        .orderStatus.id ==
                                                    3) {
                                                  context
                                                      .read<PedingOrderBloc>()
                                                      .add(
                                                          const UpdateStatusOrder(
                                                              orderStatusId:
                                                                  "4"));

                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          PedingOrderScreen
                                                              .routeName);
                                                } else if (order!
                                                        .orderStatus.id ==
                                                    4) {
                                                  context
                                                      .read<PedingOrderBloc>()
                                                      .add(
                                                          const UpdateStatusOrder(
                                                              orderStatusId:
                                                                  "5"));
                                                } else if (order!
                                                            .orderStatus.id ==
                                                        5 ||
                                                    order!.orderStatus.id ==
                                                        6 ||
                                                    order!.orderStatus.id ==
                                                        7) {
                                                  prefs.remove('order');
                                                  Navigator.pushNamed(context,
                                                      HomeScreen.routeName);
                                                }
                                              }
                                            },
                                            value: sliderValue,
                                            min: 0,
                                            max: 10,
                                            onChanged: (value) {
                                              setState(() {
                                                sliderValue = value;
                                              });
                                            })),
                                    SizedBox(
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            order!.orderStatus.statusName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
      )),
    );
  }
}
