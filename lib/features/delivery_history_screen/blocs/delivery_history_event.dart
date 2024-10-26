// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delivery_history_bloc.dart';

abstract class DeliveryHistoryEvent extends Equatable {
  const DeliveryHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersList extends DeliveryHistoryEvent {
  final String date;
  final String id;
  final String guard;

  const GetOrdersList({
    required this.date,
    required this.id,
    required this.guard,
  });

  @override
  List<Object> get props => [
    date,
    id,
    guard
  ];
}
