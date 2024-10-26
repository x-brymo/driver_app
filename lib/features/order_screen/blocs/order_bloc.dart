import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/order.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<ReceiveOrder>(_onReceiveOrder);
    on<RefuseOrder>(_onRefuseOrder);
  }

  void _onReceiveOrder(ReceiveOrder event, Emitter<OrderState> emit) async {
    emit(OrderPeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    OrderModel order = OrderModel.fromMap(jsonDecode(prefs.getString('order')!));
    String token = prefs.getString('token')!;
    
    final data = {
      "driver_id": event.driverId.toString(),
      "order_status_id": event.orderStatusId.toString(),
      "driver_accept_at": event.driverAcceptAt
    };

    ApiResponse response = await OrderService.updateOrder(
      order.id, 
      data, 
      token
    );

    if(response.success == true) {
      prefs.setString('order', jsonEncode(response.data));
      emit(OrderSuccess());
    }else {
      emit(OrderFailed());
    }
  }

  void _onRefuseOrder(RefuseOrder event, Emitter<OrderState> emit) async {
     emit(RefuseOrderPeding());
    
    final data = {
      "order_status_id": event.orderStatusId.toString(),
    };

    ApiResponse response = await OrderService.updateOrder(
      int.parse(event.id), 
      data, 
      event.token
    );

    if(response.success == true) {
      emit(RefuseOrderSuccess(apiResponse: response));
    }else {
      emit(RefuseOrderFailed(message: response.message));
    }
  }
}
