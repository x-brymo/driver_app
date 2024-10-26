part of 'peding_order_bloc.dart';

abstract class PedingOrderEvent extends Equatable {
  const PedingOrderEvent();

  @override
  List<Object> get props => [];
}

class UpdateStatusOrder extends PedingOrderEvent {
  final String orderStatusId;

  const UpdateStatusOrder({
    required this.orderStatusId
  });

  @override
  List<Object> get props => [
    orderStatusId
  ];
}