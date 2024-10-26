class RegisterModel {
  final int id;
  final String name;
  final String phoneNumber;
  RegisterModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
  

  RegisterModel copyWith({
    int? id,
    String? name,
    String? phoneNumber,
  }) {
    return RegisterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      phoneNumber: map['phone_number'] as String,
    );
  }
}
