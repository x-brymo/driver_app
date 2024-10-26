part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String token;
  final String serverKey;
  final String guard;
  
  const Login({
    required this.phoneNumber,
    required this.password,
    required this.token,
    required this.serverKey,
    required this.guard,
  });

  @override
  List<Object> get props => [
    phoneNumber, password, token, serverKey, guard
  ];
}
