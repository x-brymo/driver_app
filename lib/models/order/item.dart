// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final String itemName;
  final int quantity;
  final double price;
  
  const ItemModel({
    required this.itemName,
    required this.quantity,
    required this.price
  });

  ItemModel copyWith({
    String? itemName,
    int? quantity,
    double? price
  }) {
    return ItemModel(
      itemName: itemName ?? this.itemName, 
      quantity: quantity ?? this.quantity, 
      price: price ?? this.price
    );
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemName: map['item_name'], 
      quantity: map['quantity'],
      price: map['price']
    );
  }

  @override
  List<Object?> get props => [
    itemName,
    quantity,
    price
  ];
}