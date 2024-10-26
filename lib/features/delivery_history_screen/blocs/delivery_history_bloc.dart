import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delivery_history_event.dart';
part 'delivery_history_state.dart';

class DeliveryHistoryBloc extends Bloc<DeliveryHistoryEvent, DeliveryHistoryState> {
  DeliveryHistoryBloc() : super(DeliveryHistoryInitial()) {
    on<GetOrdersList>(_onDeliveryHistory);
  }

  void _onDeliveryHistory(GetOrdersList event, Emitter<DeliveryHistoryState> emit) async {
    emit(GetOrdersListPending());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    ApiResponse response = await OrderService.getOrdersList(
      event.date, 
      event.id,
      event.guard,
      token
    );

    if(response.success == true) {
      emit(GetOrdersListSuccess(apiResponse: response));
    }else {
      emit(GetOrderListFailed(message: response.message));
    }
  }

}
