
import 'package:equatable/equatable.dart';

class PositionModel extends Equatable {
  final double lat;
  final double lng;

  const PositionModel({required this.lat, required this.lng});

  PositionModel copyWith({double? lat, double? lng}) {
    return PositionModel(lat: lat ?? this.lat, lng: lng ?? this.lng);
  }

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
        lat: double.parse(map['lat']), lng: double.parse(map['lng']));
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lng': lng};
  }

  @override
  List<Object?> get props => [lat, lng];
}
