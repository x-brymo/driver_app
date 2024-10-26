import 'package:driver_app/models/auth/data.dart';
import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final bool success;
  final DataModel? data;
  final String message;

  const AuthResponse({
    required this.success,
    required this.data,
    required this.message
  });

  AuthResponse copyWith({
    bool? success,
    DataModel? data,
    String? message
  }) {
    return AuthResponse(
      success: success ?? this.success, 
      data: data, 
      message: message ?? this.message
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "success": success, 
      "data": data, 
      "message": message
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      success: map['success'], 
      data: map['data'] == null ? null : DataModel.fromMap(map['data']), 
      message: map['message'] ?? ''
    );
  }
  
  @override
  List<Object?> get props => [
    success,
    data,
    message
  ];
}