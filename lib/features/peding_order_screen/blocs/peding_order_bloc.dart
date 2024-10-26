import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'peding_order_event.dart';
part 'peding_order_state.dart';

class PedingOrderBloc extends Bloc<PedingOrderEvent, PedingOrderState> {
  PedingOrderBloc() : super(PedingOrderInitial()) {
    on<UpdateStatusOrder>(_onDriverArrivedToShop);
  }

  void _onDriverArrivedToShop(UpdateStatusOrder event, Emitter<PedingOrderState> emit) async {
    emit(Peding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    OrderModel order = OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
    String token = prefs.getString('token')!;

    final data = {
      "order_status_id": event.orderStatusId
    };

    ApiResponse response = await OrderService.updateOrder(
      order.id, 
      data, 
      token
    );
    prefs.setString('order', jsonEncode(response.data));

    if(response.success == true) {
      emit(PedingOrderSuccess(apiResponse: response));
    }else {
      emit(PedingOrderFailed(message: response.message));
    }
  }
}
