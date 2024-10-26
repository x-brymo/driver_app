// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterPeding extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  const RegisterFailed({
    required this.message
  });

  @override
  List<Object> get props => [
    message
  ];
}

class RegisterSuccess extends RegisterState {
  final ApiResponse authResponse;

  const RegisterSuccess({
    required this.authResponse,
  });
  
  @override 
  List<Object> get props => [
    authResponse
  ];
}
