// ignore_for_file: use_build_context_synchronously
import 'package:driver_app/features/income_statistic_screen/blocs/income_statistic_bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeStatisticScreen extends StatefulWidget {
  const IncomeStatisticScreen({super.key});

  static const routeName = 'incomeStatisticScreen';

  @override
  State<IncomeStatisticScreen> createState() => _IncomeStatisticScreenState();
}

class _IncomeStatisticScreenState extends State<IncomeStatisticScreen> {
  IncomeStatisticModel incomeStatistic =
      IncomeStatisticModel(incomeTotal: 0, deliveryTotal: 0, moveTotal: 0.0);
  bool isWeek = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thống kê thu nhập',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: SafeArea(
          child: BlocListener<IncomeStatisticBloc, IncomeStatisticState>(
              listener: (context, state) {
        if (state is GetIncomeSuccess) {
          incomeStatistic =
              IncomeStatisticModel.fromMap(state.apiResponse.data);
        }
      }, child: BlocBuilder<IncomeStatisticBloc, IncomeStatisticState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        color: Colors.green.shade700,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ButtonCustom(
                                  color: isWeek == true
                                      ? Colors.black
                                      : Colors.green.shade600,
                                  height: 70,
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      isWeek = true;
                                    });
                                    context.read<IncomeStatisticBloc>().add(
                                        GetIncome(
                                            type: 'week',
                                            id: prefs
                                                .getInt('id')!
                                                .toString()));
                                  },
                                  radius: 10.0,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 18, color: Colors.yellow),
                                  text: 'Tuần này',
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                ),
                                ButtonCustom(
                                  color: isWeek == false
                                      ? Colors.black
                                      : Colors.green.shade600,
                                  height: 70,
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      isWeek = false;
                                    });
                                    context.read<IncomeStatisticBloc>().add(
                                        GetIncome(
                                            type: 'month',
                                            id: prefs
                                                .getInt('id')!
                                                .toString()));
                                  },
                                  radius: 10.0,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 18, color: Colors.yellow),
                                  text: 'Tháng này',
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                )
                              ],
                            ),
                            const SizedBox(height: 44),
                            state is GetIncomePeding
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    '${incomeStatistic.incomeTotal.toStringAsFixed(2)} VNĐ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      ))
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3,
                right: 12,
                left: 12,
                child: state is GetIncomePeding
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width - 24,
                        height: MediaQuery.of(context).size.height / 2 -
                            AppBar().preferredSize.height,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Số chuyến đi: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.grey,
                                        )),
                                Text(
                                  '${incomeStatistic.deliveryTotal} chuyến',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tổng số km di chuyển: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.grey,
                                        )),
                                Text(
                                  '${incomeStatistic.moveTotal.toStringAsFixed(2)} km',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              )
            ],
          );
        },
      ))),
    );
  }
}
