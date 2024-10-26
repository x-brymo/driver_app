// ignore_for_file: must_be_immutable, unnecessary_this

import 'package:driver_app/models/models_export.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  PositionModel? address;
  String? avatar;
  String? fcmToken;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.address,
    this.avatar,
    this.fcmToken
  }) {
    address ??= const PositionModel(lat: 0, lng: 0);
    avatar ??= '';
    fcmToken ??= '';
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    PositionModel? address,
    String? avatar,
    String? fcmToken
  }) {
    return UserModel(
      id: id ?? this.id, 
      name: name ?? this.name, 
      phoneNumber: phoneNumber ?? this.phoneNumber, 
      address: address ?? this.address, 
      avatar: avatar ?? this.avatar, 
      fcmToken: fcmToken ?? this.fcmToken
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'], 
      name: map['name'], 
      phoneNumber: map['phone_number'],
      address: map['address'] != null ? PositionModel.fromMap(jsonDecode(map['address'])) : null,
      avatar: map['avatar'],
      fcmToken: map['fcmToken']
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    address,
    avatar,
    fcmToken
  ];
}