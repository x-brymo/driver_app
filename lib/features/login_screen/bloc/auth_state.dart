part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Peding extends AuthState {}

class Error extends AuthState {
  final String message;

  const Error({
    required this.message
  });

  @override
  List<Object> get props => [ message ];
}

class Success extends AuthState {
  final AuthResponse response;

  const Success({
    required this.response
  });

  @override
  List<Object> get props => [ response ];
}