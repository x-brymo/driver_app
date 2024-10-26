part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();
  
  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {}

class LogoutPending extends DrawerState {}

class LoggedOut extends DrawerState {}

class LogoutSuccess extends DrawerState {
  final AuthResponse authResponse;

  const LogoutSuccess({
    required this.authResponse
  });

  @override
  List<Object> get props => [
    authResponse
  ];
}

class LogoutError extends DrawerState {
  final String message;

  const LogoutError({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}