// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_app/models/models_export.dart';
import 'package:equatable/equatable.dart';

class DriverNotificationModel extends Equatable {
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final DriverModel driver;

  const DriverNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.driver,
  });

  DriverNotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    String? createdAt,
    DriverModel? driver,
  }) {
    return DriverNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      driver: driver ?? this.driver,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
      'driver': driver.toMap(),
    };
  }

  factory DriverNotificationModel.fromMap(Map<String, dynamic> map) {
    return DriverNotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      createdAt: map['created_at'] as String,
      driver: DriverModel.fromMap(map['driver'] as Map<String,dynamic>),
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    title,
    body,
    createdAt,
    driver
  ];

}
