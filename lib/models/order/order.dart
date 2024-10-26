import 'dart:convert';

import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/models/order/order_status.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final Map<String, dynamic> items;
  final PositionModel fromAddress;
  final PositionModel toAddress;
  final double shippingCost;
  final ReceiverModel receiver;
  final double driverRate;
  final double distance;
  final UserModel user;
  final String userNote;
  final DriverModel driver;
  final OrderStatusModel orderStatus;
  final String createdAt;

  const OrderModel({
    required this.id,
    required this.items,
    required this.fromAddress,
    required this.toAddress,
    required this.shippingCost,
    required this.receiver,
    required this.driverRate,
    required this.distance,
    required this.user,
    required this.userNote,
    required this.driver,
    required this.orderStatus,
    required this.createdAt
  });

  OrderModel copyWith({
    int? id,
    Map<String, dynamic>? items,
    PositionModel? fromAddress,
    PositionModel? toAddress,
    double? shippingCost,
    ReceiverModel? receiver,
    double? driverRate,
    double? distance,
    UserModel? user,
    String? userNote,
    DriverModel? driver,
    OrderStatusModel? orderStatus,
    String? createdAt
  }) {
    return OrderModel(
      id: id ?? this.id, 
      items: items ?? this.items, 
      fromAddress: fromAddress ?? this.fromAddress, 
      toAddress: toAddress ?? this.toAddress, 
      shippingCost: shippingCost ?? this.shippingCost, 
      receiver: receiver ?? this.receiver, 
      driverRate: driverRate ?? this.driverRate, 
      distance: distance ?? this.distance, 
      user: user ?? this.user, 
      userNote: userNote ?? this.userNote,
      driver: driver ?? this.driver, 
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt
    );
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'], 
      items: jsonDecode(map['items']), 
      fromAddress: PositionModel.fromMap(jsonDecode(map['from_address'])), 
      toAddress: PositionModel.fromMap(jsonDecode(map['to_address'])), 
      shippingCost: map['shipping_cost'], 
      receiver: ReceiverModel.fromMap(jsonDecode(map['receiver'])), 
      driverRate: double.parse(map['driver_rate'].toString()), 
      distance: map['distance'], 
      user: UserModel.fromMap(map['user']), 
      userNote: map['user_note'] ?? '',
      driver: DriverModel.fromMap(map['driver']), 
      orderStatus: OrderStatusModel.fromMap(map['order_status']),
      createdAt: map['created_at']
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    items,
    fromAddress,
    toAddress,
    shippingCost,
    receiver,
    driverRate,
    distance,
    user,
    userNote,
    driver,
    orderStatus,
    createdAt
  ];
}