// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'driver_notification_bloc.dart';

abstract class DriverNotificationEvent extends Equatable {
  const DriverNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetDriverNotifications extends DriverNotificationEvent {
  final String guard;
  final String id;

  const GetDriverNotifications({
    required this.guard,
    required this.id,
  });

  @override
  List<Object> get props => [
    guard,
    id
  ];
}
