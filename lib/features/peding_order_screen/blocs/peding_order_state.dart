part of 'peding_order_bloc.dart';

abstract class PedingOrderState extends Equatable {
  const PedingOrderState();
  
  @override
  List<Object> get props => [];
}

class PedingOrderInitial extends PedingOrderState {}

class Peding extends PedingOrderState {}

class PedingOrderFailed extends PedingOrderState {
  final String message;

  const PedingOrderFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}

class PedingOrderSuccess extends PedingOrderState {
  final ApiResponse apiResponse;

  const PedingOrderSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}