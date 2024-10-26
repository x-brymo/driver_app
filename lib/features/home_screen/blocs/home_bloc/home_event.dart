// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class DriverActive extends HomeEvent {
  final String currentLocation;
  final int status;

  const DriverActive({
    required this.currentLocation,
    required this.status
  });

  @override
  List<Object> get props => [ 
    currentLocation,
    status
  ];
}

class UpdateDriverLocation extends HomeEvent {
  final String lat;
  final String lng;
  final String receiverId;

  const UpdateDriverLocation({
    required this.lat,
    required this.lng,
    required this.receiverId,
  });

  @override
  List<Object> get props => [ 
    lat,
    lng,
    receiverId
  ];
}
