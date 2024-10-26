import 'package:equatable/equatable.dart';

class ReceiverModel extends Equatable {
  final String name;
  final String phoneNumber;
 
  const ReceiverModel({
    required this.name,
    required this.phoneNumber,
  });

  ReceiverModel copyWith({
    String? name,
    String? phoneNumber,
  }) {
    return ReceiverModel(
      name: name ?? this.name, 
      phoneNumber: phoneNumber ?? this.phoneNumber, 
    );
  }

  factory ReceiverModel.fromMap(Map<String, dynamic> map) {
    return ReceiverModel(
      name: map['name'], 
      phoneNumber: map['phone_number'], 
    );
  }

  @override
  List<Object?> get props => [
    name,
    phoneNumber
  ];
}