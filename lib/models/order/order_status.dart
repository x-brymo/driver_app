import 'package:equatable/equatable.dart';

class OrderStatusModel extends Equatable {
  final int id;
  final String statusName;

  const OrderStatusModel({
    required this.id,
    required this.statusName
  });

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      id: map['id'], 
      statusName: map['status_name']
    );
  }

  @override
  List<Object?> get props => [
    id, statusName
  ];

}