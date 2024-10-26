import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'income_statistic_event.dart';
part 'income_statistic_state.dart';

class IncomeStatisticBloc extends Bloc<IncomeStatisticEvent, IncomeStatisticState> {
  IncomeStatisticBloc() : super(IncomeStatisticInitial()) {
    on<GetIncome>(_onGetIncome);
  }

  void _onGetIncome(GetIncome event, Emitter<IncomeStatisticState> emit) async {
    emit(GetIncomePeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    ApiResponse response = await OrderService.getIncomeStatistic(event.type, event.id, token);
    log('BLOC: ${response.data}');
    if(response.success == true) {
      emit(GetIncomeSuccess(apiResponse: response));
    }else {
      emit(GetIncomeFailed(message: response.message));
    }
  }
}
