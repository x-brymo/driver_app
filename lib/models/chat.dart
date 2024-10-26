// ignore_for_file: prefer_null_aware_operators

import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final int id;
  final String message;
  final String orderId;
  final String createdAt;
  final String? senderId;
  const ChatModel({
    required this.id,
    required this.message,
    required this.orderId,
    required this.createdAt,
    this.senderId,
  });

  @override
  List<Object> get props {
    return [
      id,
      message,
      orderId,
      createdAt,
      senderId!,
    ];
  }

  ChatModel copyWith({
    int? id,
    String? message,
    String? orderId,
    String? createdAt,
    String? senderId,
  }) {
    return ChatModel(
      id: id ?? this.id,
      message: message ?? this.message,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'orderId': orderId,
      'createdAt': createdAt,
      'senderId': senderId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      message: map['message'].toString(),
      orderId:map['order_id'].toString(),
      createdAt: map['created_at'].toString(),
      senderId: map['sender_id'] == null ? null : map['sender_id'].toString(),
    );
  }
}
