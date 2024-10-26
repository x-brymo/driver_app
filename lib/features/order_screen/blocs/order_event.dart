// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class ReceiveOrder extends OrderEvent {
  final int driverId;
  final int orderStatusId;
  final String driverAcceptAt;

  const ReceiveOrder({
    required this.driverId,
    required this.orderStatusId,
    required this.driverAcceptAt
  });

  @override
  List<Object> get props => [
    driverId,
    orderStatusId,
    driverAcceptAt
  ];
}

class RefuseOrder extends OrderEvent {
  final String id;
  final String token;
  final String orderStatusId;

  const RefuseOrder({
    required this.id,
    required this.token,
    required this.orderStatusId,
  });

  @override
  List<Object> get props => [
    id,
    token,
    orderStatusId
  ];
}
