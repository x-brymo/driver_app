// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  final String name;
  final String phoneNumber;
  final String password;
  final String repeatPassword;

  const Register({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.repeatPassword,
  });

   @override
  List<Object> get props => [
    name,
    phoneNumber,
    password,
    repeatPassword
  ];
}
