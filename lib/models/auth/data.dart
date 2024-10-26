import 'package:driver_app/models/models_export.dart';
import 'package:equatable/equatable.dart';

class DataModel extends Equatable {
  final DriverModel driver;
  final String token;

  const DataModel({
    required this.driver,
    required this.token
  });

  DataModel copyWith({
    DriverModel? driver,
    String? token
  }) {
    return DataModel(
      driver: driver ?? this.driver, 
      token: token ?? this.token
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "driver": driver, 
      "token": token
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      driver: DriverModel.fromMap(map['driver']), 
      token: map['token']
    );
  }
  
  @override
  List<Object?> get props => [
    driver, 
    token
  ];
}