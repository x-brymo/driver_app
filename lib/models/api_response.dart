import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final bool success;
  final dynamic data;
  final String message;

  const ApiResponse({
    required this.success,
    required this.data,
    required this.message
  });

  ApiResponse copyWith({
    bool? success,
    dynamic data,
    String? message
  }) {
    return ApiResponse(
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

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      success: map['success'], 
      data: map['data'], 
      message: map['message']
    );
  }
  
  @override
  List<Object?> get props => [
    success,
    data,
    message
  ];
}