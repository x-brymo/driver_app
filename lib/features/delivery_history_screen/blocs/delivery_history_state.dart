part of 'delivery_history_bloc.dart';

abstract class DeliveryHistoryState extends Equatable {
  const DeliveryHistoryState();
  
  @override
  List<Object> get props => [];
}

class DeliveryHistoryInitial extends DeliveryHistoryState {}

class GetOrdersListPending extends DeliveryHistoryState {}

class GetOrdersListSuccess extends DeliveryHistoryState {
  final ApiResponse apiResponse;

  const GetOrdersListSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}

class GetOrderListFailed extends DeliveryHistoryState {
  final String message;

  const GetOrderListFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}