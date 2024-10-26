part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UpdateProfilePeding extends ProfileState {}

class UpdateProfileFailed extends ProfileState {
  final String message;

  const UpdateProfileFailed({
    required this.message,
  });

  @override
  List<Object> get props => [ message ];
}

class UpdateProfileSuccess extends ProfileState {
  final ApiResponse apiResponse;

  const UpdateProfileSuccess({
    required this.apiResponse,
  });

  @override
  List<Object> get props => [ apiResponse ];
}
