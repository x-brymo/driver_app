part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String phoneNumber;
  final String avatar;

  const UpdateProfile({
    required this.name,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  List<Object> get props => [
    name,
    phoneNumber,
    avatar
  ];
}
