part of 'driver_notification_bloc.dart';

abstract class DriverNotificationState extends Equatable {
  const DriverNotificationState();
  
  @override
  List<Object> get props => [];
}

class DriverNotificationInitial extends DriverNotificationState {}

class GetDriverNotificationsPeding extends DriverNotificationState {}

class GetDriverNotificationsSuccess extends DriverNotificationState {
  final ApiResponse apiResponse;

  const GetDriverNotificationsSuccess({
    required this.apiResponse
  });

  @override
  List<Object> get props => [
    apiResponse
  ];
}

class GetDriverNotificationsFailed extends DriverNotificationState {
  final String message;

  const GetDriverNotificationsFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}