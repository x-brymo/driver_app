// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderPeding extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailed extends OrderState {}

class RefuseOrderPeding extends OrderState {}

class RefuseOrderFailed extends OrderState {
  final String message;

  const RefuseOrderFailed({
    required this.message,
  });

  @override
  List<Object> get props => [ message ];
}

class RefuseOrderSuccess extends OrderState {
  final ApiResponse apiResponse;

  const RefuseOrderSuccess({
    required this.apiResponse,
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}
