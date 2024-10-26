import 'dart:convert';

import 'package:driver_app/models/models_export.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DriverModel extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  String? avatar;
  double? reviewRate;
  PositionModel? currentLocation;
  final int status;
  String? fcmToken;

  DriverModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatar,
    this.reviewRate,
    this.currentLocation,
    required this.status,
    this.fcmToken
  }) {
    avatar ??= '';
    reviewRate ??= 0;
    currentLocation ??= const PositionModel(lat: 0.0, lng: 0.0);
    fcmToken = fcmToken ?? '';
  }

  DriverModel copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? avatar,
    double? reviewRate,
    PositionModel? currentLocation,
    int? status,
    String? fcmToken,
  }) {
    return DriverModel(
      id: id ?? this.id, 
      name: name ?? this.name, 
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      reviewRate: reviewRate ?? this.reviewRate,
      currentLocation: currentLocation ?? this.currentLocation,
      status: status ?? this.status,
      fcmToken: fcmToken ?? this.fcmToken
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id, 
      "name": name, 
      "phoneNumber": phoneNumber,
      "avatar": avatar,
      "reviewRate": reviewRate,
      "currentLocation": currentLocation,
      "status": status,
      "fcmToken": fcmToken
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'], 
      name: map['name'], 
      phoneNumber: map['phone_number'],
      avatar: map['avatar'],
      reviewRate: map['review_rate'],
      currentLocation: map['current_location'] != null 
        ? PositionModel.fromMap(jsonDecode(map['current_location'])) 
        : const PositionModel(lat: 0.0, lng: 0.0),
      status: map['status'],
      fcmToken: map['fcm_token']
    );
  }
  
  @override
  List<Object?> get props => [
    id, 
    name, 
    phoneNumber,
    avatar,
    reviewRate,
    currentLocation,
    status,
    fcmToken
  ];
}