// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {}

class ActiveSuccess extends HomeState {}

class ActiveFailed extends HomeState {}

class UpdatedDriverLocationPeding extends HomeState {}

class UpdatedDriverLocationFailed extends HomeState {
  final String message;

  const UpdatedDriverLocationFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdatedDriverLocationSuccess extends HomeState {
  final ApiResponse apiResponse;

  const UpdatedDriverLocationSuccess({
    required this.apiResponse,
  });

  @override
  List<Object> get props => [apiResponse];
}
